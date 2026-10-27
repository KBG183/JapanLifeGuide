package com.japanlife;

import static org.assertj.core.api.Assertions.assertThat;
import static org.assertj.core.api.Assertions.assertThatThrownBy;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;
import com.japanlife.mapper.ProcedureMapper;
import com.japanlife.service.ProcedureService;
import com.japanlife.service.TaskService;
import com.japanlife.service.MemberService;
import com.japanlife.service.EmailVerificationService;
import com.japanlife.service.PasswordResetService;
import com.japanlife.service.CommunityService;
import com.japanlife.service.AdminContentService;
import java.time.YearMonth;
import java.time.LocalDateTime;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.util.HexFormat;
import org.springframework.mock.web.MockMultipartFile;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("preview")
@Transactional
class ProcedureIntegrationTest {
    @Autowired MockMvc mvc;
    @Autowired ProcedureService service;
    @Autowired ProcedureMapper mapper;
    @Autowired JdbcTemplate jdbc;
    @Autowired TaskService taskService;
    @Autowired MemberService memberService;
    @Autowired EmailVerificationService emailVerificationService;
    @Autowired PasswordResetService passwordResetService;
    @Autowired CommunityService communityService;
    @Autowired AdminContentService adminContentService;

    @Test void listReadsTheSeedDatabase() throws Exception {
        mvc.perform(get("/procedures")).andExpect(status().isOk())
            .andExpect(view().name("procedures/list"))
            .andExpect(model().attribute("total", 19))
            .andExpect(model().attribute("pages", 4))
            .andExpect(model().attribute("items", org.hamcrest.Matchers.hasSize(6)))
            .andExpect(model().attribute("preview", true));
    }

    @Test void detailLanguageSwitchLoadsTranslatedProcedureDocumentsAndSources() throws Exception {
        mvc.perform(get("/procedures/1").param("lang", "ko"))
            .andExpect(status().isOk())
            .andExpect(model().attribute("currentLanguage", "ko"))
            .andExpect(model().attribute("procedure", org.hamcrest.Matchers.hasProperty("title", org.hamcrest.Matchers.equalTo("해외에서 미나토구로 이사"))));
        assertThat(service.documents(1, "ko")).extracting("name").contains("여권");
        var koDocs = service.documents(1, "ko");
        var resCardDoc = koDocs.stream().filter(d -> d.getId() == 2).findFirst().orElseThrow();
        assertThat(resCardDoc.getDescription()).contains("재류자격을 확인하는 증명서");
        assertThat(resCardDoc.getPreparationNote()).contains("재류카드는 공항 또는 출입국재류관리청에서 교부됩니다");
        assertThat(service.detail(1, "ko").getTitle()).isNotEqualTo("海外から港区へ引っ越す");
        mvc.perform(get("/procedures/1").param("lang", "en"))
            .andExpect(status().isOk())
            .andExpect(model().attribute("currentLanguage", "en"))
            .andExpect(model().attribute("procedure", org.hamcrest.Matchers.hasProperty("title", org.hamcrest.Matchers.equalTo("Moving to Minato City from overseas"))));
        assertThat(service.documents(1, "en")).extracting("name").contains("Passport");
        assertThat(service.detail(1, "en").getTitle()).isNotEqualTo("海外から港区へ引っ越す");
    }

    @Test void japaneseSearchAndSituationFilterWorkTogether() throws Exception {
        mvc.perform(get("/procedures").param("q", "海外").param("situation", "ABROAD"))
            .andExpect(status().isOk()).andExpect(model().attribute("total", 1));
        assertThat(service.search("海外", "DOMESTIC", 1)).isEmpty();
    }

    @Test void phaseFilterWorksAndRejectsUnknownValues() throws Exception {
        mvc.perform(get("/procedures").param("phase", "AFTER_ARRIVAL"))
            .andExpect(status().isOk()).andExpect(model().attribute("total", 4));
        mvc.perform(get("/procedures").param("phase", "UNKNOWN"))
            .andExpect(status().isBadRequest());
    }

    @Test void percentAndUnderscoreAreLiteralSearchCharacters() {
        assertThat(service.count("%", "")).isZero();
        assertThat(service.count("_", "")).isZero();
        assertThat(service.count("!", "")).isZero();
    }

    @Test void sqlInjectionIsTreatedAsSearchText() {
        assertThat(service.count("' OR '1'='1", "")).isZero();
        assertThat(service.count("", "")).isEqualTo(19);
    }

    @Test void unpublishedRecordsCannotBeListedOrOpened() throws Exception {
        jdbc.update("UPDATE JL_PROCEDURE SET published='N' WHERE id=1");
        assertThat(service.count("", "")).isEqualTo(18);
        mvc.perform(get("/procedures/1")).andExpect(status().isNotFound());
    }

    @Test void missingDetailIs404() throws Exception {
        mvc.perform(get("/procedures/99999")).andExpect(status().isNotFound());
    }

    @Test void detailContainsConditionalDocumentsAndDatedSources() {
        assertThat(mapper.findDocuments(2)).anySatisfy(doc -> {
            assertThat(doc.getName()).isEqualTo("転出証明書");
            assertThat(doc.getRequirement()).isEqualTo("CONDITIONAL");
            assertThat(doc.getConditionText()).contains("カード");
            assertThat(doc.getDescription()).isNotBlank();
            assertThat(doc.getPreparationNote()).isNotBlank();
        });
        assertThat(mapper.findSources(1)).allSatisfy(source -> {
            assertThat(source.getCheckedOn()).isEqualTo("2026-09-28");
            assertThat(source.getUrl()).startsWith("https://www.city.minato.tokyo.jp/");
        });
    }

    @Test void paginationUsesStableOrderAndNonOverlappingBoundaries() {
        assertThat(mapper.search("%", "", 0, 1)).extracting("id").containsExactly(1L);
        assertThat(mapper.search("%", "", 1, 2)).extracting("id").containsExactly(2L);
    }

    @Test void invalidInputsAre400AndPageValuesAreClamped() throws Exception {
        mvc.perform(get("/procedures").param("situation", "UNKNOWN")).andExpect(status().isBadRequest());
        mvc.perform(get("/procedures").param("q", "x".repeat(81))).andExpect(status().isBadRequest());
        mvc.perform(get("/procedures").param("page", "bad")).andExpect(status().isBadRequest());
        mvc.perform(get("/procedures").param("page", "2147483647"))
            .andExpect(status().isOk()).andExpect(model().attribute("page", 4));
        mvc.perform(get("/procedures").param("page", "-5"))
            .andExpect(status().isOk()).andExpect(model().attribute("page", 1));
    }

    @Test void conditionalDocumentRequiresAnExplanation() {
        assertThatThrownBy(() -> jdbc.update("INSERT INTO JL_DOCUMENT VALUES (99,1,'test','CONDITIONAL',NULL,99)"))
            .isInstanceOf(DataIntegrityViolationException.class);
    }

    @Test void futureTaskSchemaSeparatesOwnersAndBlocksDuplicates() {
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (91,'test-a','test-only','A')");
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (92,'test-b','test-only','B')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (91,91,1,1,'test')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (92,92,1,1,'test')");
        assertThatThrownBy(() -> jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (93,91,1,1,'test')"))
            .isInstanceOf(DataIntegrityViolationException.class);
    }

    @Test void completedTaskNeedsAnExplicitCompletionTimestamp() {
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (94,'test-c','test-only','C')");
        assertThatThrownBy(() -> jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title,status) VALUES (94,94,1,1,'test','COMPLETED')"))
            .isInstanceOf(DataIntegrityViolationException.class);
    }

    @Test void taskCalendarStoresAndOwnsEvents() {
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (95,'calendar-user','test-only','Calendar')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (95,95,1,1,'calendar task')");
        var createdEvent = taskService.addEvent("calendar-user", 95, "2026-10-15", "창구 방문", "서류를 확인");
        assertThat(taskService.events("calendar-user", YearMonth.of(2026, 10))).hasSize(1)
            .first().satisfies(savedEvent -> {
                assertThat(savedEvent.getEventDate()).isEqualTo("2026-10-15");
                assertThat(savedEvent.getTaskTitle()).isEqualTo("calendar task");
            });
        assertThat(taskService.toggleEvent("calendar-user", createdEvent.getId())).isTrue();
        assertThat(taskService.deleteEvent("calendar-user", createdEvent.getId())).isTrue();
    }

    @Test void taskCalendarRejectsInvalidDatesAsInputErrors() {
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (96,'invalid-date-user','test-only','Invalid date')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (96,96,1,1,'calendar task')");
        assertThatThrownBy(() -> taskService.addEvent("invalid-date-user", 96, "2026-02-30", "창구 방문", null))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("invalid event date");
    }

    @Test void deletingTaskRemovesOwnedChecklistAndEvents() {
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (98,'delete-user','test-only','Delete')");
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (99,'other-user','test-only','Other')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (98,98,1,1,'delete task')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (99,99,1,1,'other task')");
        jdbc.update("INSERT INTO JL_USER_CHECK (id,task_id,document_name,requirement,display_order) VALUES (99,98,'A','REQUIRED',1)");
        taskService.addEvent("delete-user", 98, "2026-10-15", "삭제 일정", null);

        assertThat(taskService.delete("other-user", 98)).isFalse();
        assertThat(taskService.delete("delete-user", 98)).isTrue();
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_USER_TASK WHERE id=98", Integer.class)).isZero();
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_USER_CHECK WHERE task_id=98", Integer.class)).isZero();
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_USER_TASK_EVENT WHERE task_id=98", Integer.class)).isZero();
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_USER_TASK WHERE id=99", Integer.class)).isEqualTo(1);
    }

    @Test void registrationHashesPasswordsAndPrivatePagesRequireLogin() throws Exception {
        memberService.register("secure-user", "password123", "Secure User");
        String stored = jdbc.queryForObject("SELECT password_hash FROM JL_MEMBER WHERE login_id='secure-user'", String.class);
        assertThat(stored).startsWith("$2").isNotEqualTo("password123");
        mvc.perform(get("/login")).andExpect(status().isOk()).andExpect(view().name("auth/login"));
        mvc.perform(get("/register")).andExpect(status().isOk()).andExpect(view().name("auth/register"));
        mvc.perform(get("/my/tasks")).andExpect(status().is3xxRedirection())
            .andExpect(redirectedUrlPattern("**/login"));
    }

    @Test void loginIdDuplicateCheckValidatesFormatAndAvailability() throws Exception {
        mvc.perform(get("/register/check-login-id").param("loginId", "new-user"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.available").value(true));
        jdbc.update("INSERT INTO JL_MEMBER (id, login_id, password_hash, display_name, role) VALUES (99, 'existing-user', 'hash', 'Existing', 'MEMBER')");
        mvc.perform(get("/register/check-login-id").param("loginId", "existing-user"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.available").value(false));
        mvc.perform(get("/register/check-login-id").param("loginId", "bad"))
            .andExpect(status().isOk()).andExpect(jsonPath("$.available").value(false))
            .andExpect(jsonPath("$.reason").value("invalid"));
    }

    @Test void emailFormatAndDuplicateCheckWork() throws Exception {
        assertThat(EmailVerificationService.isValidEmail("person@example.com")).isTrue();
        assertThat(EmailVerificationService.isValidEmail("invalid-email")).isFalse();
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name,email,email_verified) VALUES (110,'email-user','test-only','Email','used@example.com','Y')");
        mvc.perform(get("/register/check-email").param("email", "used@example.com"))
            .andExpect(status().isOk()).andExpect(content().json("{\"available\":false}"));
        mvc.perform(get("/register/check-email").param("email", "new@example.com"))
            .andExpect(status().isOk()).andExpect(content().json("{\"available\":true}"));
    }

    @Test void emailVerificationRejectsWrongExpiredAndReusedCodes() throws Exception {
        String code = "123456";
        String hash = HexFormat.of().formatHex(MessageDigest.getInstance("SHA-256")
                .digest(code.getBytes(StandardCharsets.UTF_8)));
        jdbc.update("INSERT INTO JL_EMAIL_VERIFICATION (id,email,code_hash,expires_at,sent_at,attempt_count) VALUES (401,?,?,?,?,0)",
                "verify@example.com", hash, LocalDateTime.now().plusMinutes(10), LocalDateTime.now());
        assertThat(emailVerificationService.verify("verify@example.com", "000000")).isFalse();
        assertThat(emailVerificationService.verify("verify@example.com", code)).isTrue();
        assertThat(emailVerificationService.verify("verify@example.com", code)).isFalse();

        jdbc.update("INSERT INTO JL_EMAIL_VERIFICATION (id,email,code_hash,expires_at,sent_at,attempt_count) VALUES (402,?,?,?,?,0)",
                "expired@example.com", hash, LocalDateTime.now().minusMinutes(1), LocalDateTime.now().minusMinutes(11));
        assertThat(emailVerificationService.verify("expired@example.com", code)).isFalse();
    }


    @Test void passwordResetPageIsPublicAndShortPasswordIsRejected() throws Exception {
        mvc.perform(get("/forgot-password"))
            .andExpect(status().isOk()).andExpect(view().name("auth/forgot-password"));
        assertThat(passwordResetService.resetPassword(9999L, "short", "short")).isFalse();
    }

    @Test void findLoginIdPageIsPublic() throws Exception {
        mvc.perform(get("/find-login-id"))
            .andExpect(status().isOk()).andExpect(view().name("auth/find-login-id"));
    }

    @Test void policyPagesArePublicAndUseTheirViews() throws Exception {
        mvc.perform(get("/privacy"))
            .andExpect(status().isOk()).andExpect(view().name("policy/privacy"));
        mvc.perform(get("/terms"))
            .andExpect(status().isOk()).andExpect(view().name("policy/terms"));
        mvc.perform(get("/community/rules"))
            .andExpect(status().isOk()).andExpect(view().name("policy/community-rules"));
    }

    @Test void loginPagePreservesInternalContinueTarget() throws Exception {
        mvc.perform(get("/login").param("returnTo", "/community/15"))
            .andExpect(status().isOk())
            .andExpect(view().name("auth/login"))
            .andExpect(model().attribute("loginReturnTo", "/community/15"));
    }


    @Test void checklistAutomaticallyCalculatesAndResetsTaskStatus() {
        jdbc.update("INSERT INTO JL_MEMBER (id,login_id,password_hash,display_name) VALUES (97,'check-user','test-only','Checklist')");
        jdbc.update("INSERT INTO JL_USER_TASK (id,member_id,procedure_id,saved_revision,saved_title) VALUES (97,97,1,1,'checklist task')");
        jdbc.update("INSERT INTO JL_USER_CHECK (id,task_id,document_name,requirement,display_order) VALUES (97,97,'A','REQUIRED',1)");
        jdbc.update("INSERT INTO JL_USER_CHECK (id,task_id,document_name,requirement,display_order) VALUES (98,97,'B','REQUIRED',2)");
        assertThat(taskService.saveChecks("check-user", 97, java.util.List.of(97L))).isTrue();
        assertThat(jdbc.queryForObject("SELECT status FROM JL_USER_TASK WHERE id=97", String.class)).isEqualTo("PREPARING");
        assertThat(taskService.saveChecks("check-user", 97, java.util.List.of(97L, 98L))).isTrue();
        assertThat(jdbc.queryForObject("SELECT status FROM JL_USER_TASK WHERE id=97", String.class)).isEqualTo("COMPLETED");
        assertThat(jdbc.queryForObject("SELECT completed_at FROM JL_USER_TASK WHERE id=97", java.sql.Timestamp.class)).isNotNull();
        assertThat(taskService.saveChecks("check-user", 97, java.util.List.of())).isTrue();
        assertThat(jdbc.queryForObject("SELECT status FROM JL_USER_TASK WHERE id=97", String.class)).isEqualTo("NOT_STARTED");
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_USER_TASK WHERE id=97 AND completed_at IS NULL", Integer.class)).isEqualTo(1);
        assertThat(taskService.updateCheck("check-user", 97, 97, true)).isTrue();
        assertThat(jdbc.queryForObject("SELECT status FROM JL_USER_TASK WHERE id=97", String.class)).isEqualTo("PREPARING");
        assertThat(taskService.updateCheck("check-user", 97, 98, true)).isTrue();
        assertThat(jdbc.queryForObject("SELECT status FROM JL_USER_TASK WHERE id=97", String.class)).isEqualTo("COMPLETED");
    }

    @Test void communityCreateListCommentViewAndLikeFlowWorks() {
        memberService.register("community-user", "password123", "Community User");
        long postId = communityService.create("community-user", "GENERAL", "테스트 제목", "테스트 본문", null);

        assertThat(communityService.countPosts("", "테스트")).isEqualTo(1);
        assertThat(communityService.posts("GENERAL", "테스트", 1, 10))
            .extracting(post -> ((Number) post.get("ID")).longValue()).contains(postId);
        assertThat(((Number) communityService.post(postId).get("VIEW_COUNT")).longValue()).isEqualTo(1L);

        communityService.comment("community-user", postId, "댓글 내용");
        assertThat(communityService.comments(postId)).anySatisfy(comment -> {
            assertThat(comment.get("BODY")).isEqualTo("댓글 내용");
            assertThat(comment.get("DISPLAY_NAME")).isEqualTo("Community User");
            assertThat(comment.get("LOGIN_ID")).isEqualTo("community-user");
            assertThat(comment.get("CREATED_AT")).isNotNull();
        });
        assertThat(communityService.like("community-user", postId)).isTrue();
        assertThat(communityService.likedBy("community-user", postId)).isTrue();
        assertThat(communityService.likeCount(postId)).isEqualTo(1);
        assertThat(communityService.like("community-user", postId)).isFalse();
        assertThat(communityService.likedBy("community-user", postId)).isFalse();
    }

    @Test void communityBookmarkCommentEditAndNotificationFlowWorks() {
        memberService.register("feature-owner", "password123", "Feature Owner");
        memberService.register("feature-actor", "password123", "Feature Actor");
        long postId = communityService.create("feature-owner", "GENERAL", "기능 테스트 게시글", "기능 테스트 본문", null);

        assertThat(communityService.bookmarkedBy("feature-actor", postId)).isFalse();
        assertThat(communityService.bookmark("feature-actor", postId)).isTrue();
        assertThat(communityService.bookmarkedBy("feature-actor", postId)).isTrue();
        assertThat(communityService.bookmarks("feature-actor"))
            .anySatisfy(post -> assertThat(((Number) post.get("ID")).longValue()).isEqualTo(postId));

        communityService.comment("feature-actor", postId, "알림 테스트 댓글");
        var comment = communityService.comments(postId).stream()
            .filter(row -> "알림 테스트 댓글".equals(row.get("BODY"))).findFirst().orElseThrow();
        long commentId = ((Number) comment.get("ID")).longValue();
        communityService.updateComment("feature-actor", commentId, postId, "수정된 알림 테스트 댓글");
        assertThat(communityService.comments(postId)).anySatisfy(row -> {
            assertThat(row.get("BODY")).isEqualTo("수정된 알림 테스트 댓글");
            assertThat(row.get("UPDATED_AT")).isNotNull();
        });

        var notifications = communityService.notifications("feature-owner");
        assertThat(notifications).anySatisfy(notification -> {
            assertThat(notification.get("NOTIFICATION_TYPE")).isEqualTo("COMMENT");
            assertThat(((Number) notification.get("POST_ID")).longValue()).isEqualTo(postId);
            assertThat(notification.get("READ_AT")).isNull();
        });
        long notificationId = ((Number) notifications.get(0).get("ID")).longValue();
        communityService.markNotificationRead("feature-owner", notificationId);
        assertThat(communityService.notifications("feature-owner")).anySatisfy(notification -> {
            if (((Number) notification.get("ID")).longValue() == notificationId) {
                assertThat(notification.get("READ_AT")).isNotNull();
            }
        });
    }

    @Test void communityEditRequiresPostOwner() {
        memberService.register("edit-page-owner", "password123", "Edit Page Owner");
        memberService.register("edit-page-other", "password123", "Edit Page Other");
        long postId = communityService.create("edit-page-owner", "GENERAL", "수정 권한 테스트", "본문", null);

        assertThat(communityService.editablePost("edit-page-owner", postId)).isNotNull();
        assertThatThrownBy(() -> communityService.editablePost("edit-page-other", postId))
            .isInstanceOfSatisfying(org.springframework.web.server.ResponseStatusException.class,
                error -> assertThat(error.getStatusCode().value()).isEqualTo(404));
    }

    @Test void memberStatusAndRoleChangesCreateAuditHistory() {
        memberService.register("audit-target", "password123", "Audit Target");
        memberService.register("audit-admin", "password123", "Audit Admin");
        var target = memberService.findByLoginId("audit-target");
        var admin = memberService.findByLoginId("audit-admin");

        assertThat(memberService.updateStatus(target.getId(), "INACTIVE", admin.getId(), "test status change")).isTrue();
        assertThat(memberService.updateRole(target.getId(), "ADMIN", admin.getId(), "test role change")).isTrue();
        assertThat(memberService.audit()).anySatisfy(row -> {
            assertThat(row.get("MEMBER_LOGIN_ID")).isEqualTo("audit-target");
            assertThat(row.get("ADMIN_LOGIN_ID")).isEqualTo("audit-admin");
        });
    }

    @Test void missingCommunityPostIs404() throws Exception {
        mvc.perform(get("/community/99999")).andExpect(status().isNotFound());
    }

    @Test void communityRejectsFileWhoseBytesDoNotMatchItsImageType() {
        memberService.register("image-user", "password123", "Image User");
        var fakeImage = new MockMultipartFile("images", "fake.png", "image/png", "not a png".getBytes(StandardCharsets.UTF_8));
        assertThatThrownBy(() -> communityService.create("image-user", "GENERAL", "이미지 테스트", "본문", new MockMultipartFile[] {fakeImage}))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("image");
        assertThat(communityService.countPosts("", "이미지 테스트")).isZero();
    }

    @Test void hiddenCommunityPostImagesAreNotServed() throws Exception {
        memberService.register("image-visibility-user", "password123", "Image Visibility User");
        byte[] pngHeader = new byte[] {(byte) 0x89, 0x50, 0x4e, 0x47};
        var image = new MockMultipartFile("images", "visible.png", "image/png", pngHeader);
        long postId = communityService.create("image-visibility-user", "GENERAL", "이미지 공개 상태", "본문", new MockMultipartFile[] {image});
        String storedName = jdbc.queryForObject("SELECT stored_name FROM JL_COMMUNITY_IMAGE WHERE post_id=?", String.class, postId);

        assertThat(communityService.image(storedName)).isNotNull();
        communityService.updatePostStatus(postId, "HIDDEN");
        assertThat(communityService.image(storedName)).isNull();
    }

    @Test void communityReportsCannotTargetOwnContentOrCreateDuplicateOpenReports() {
        memberService.register("report-owner", "password123", "Report Owner");
        memberService.register("report-user", "password123", "Report User");
        long postId = communityService.create("report-owner", "GENERAL", "신고 테스트", "본문", null);

        assertThatThrownBy(() -> communityService.reportPost("report-owner", postId, "자기 글 신고"))
            .isInstanceOf(IllegalArgumentException.class)
            .hasMessage("own post");

        communityService.reportPost("report-user", postId, "첫 신고");
        communityService.reportPost("report-user", postId, "중복 신고");
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_COMMUNITY_REPORT WHERE post_id=?", Integer.class, postId))
            .isEqualTo(1);
        assertThat(communityService.reports()).anySatisfy(report -> {
            assertThat(report.get("REPORTER_LOGIN_ID")).isEqualTo("report-user");
            assertThat(report.get("POST_TITLE")).isEqualTo("신고 테스트");
            assertThat(report.get("POST_AUTHOR_DISPLAY_NAME")).isEqualTo("Report Owner");
            assertThat(report.get("TARGET_POST_ID")).isNotNull();
        });
    }

    @Test void commentReportRejectsCommentOnHiddenPost() {
        memberService.register("hidden-comment-owner", "password123", "Hidden Comment Owner");
        memberService.register("hidden-comment-reporter", "password123", "Hidden Comment Reporter");
        long postId = communityService.create("hidden-comment-owner", "GENERAL", "비공개 댓글 신고", "본문", null);
        communityService.comment("hidden-comment-owner", postId, "신고 대상 댓글");
        long commentId = ((Number) communityService.comments(postId).get(0).get("ID")).longValue();
        communityService.updatePostStatus(postId, "HIDDEN");

        assertThatThrownBy(() -> communityService.reportComment("hidden-comment-reporter", commentId, "비공개 게시글 댓글 신고"))
            .isInstanceOf(org.springframework.web.server.ResponseStatusException.class);
    }

    @Test void adminModerationAppliesReportDecisionToPostAndComment() {
        memberService.register("moderation-owner", "password123", "Moderation Owner");
        memberService.register("moderation-reporter", "password123", "Moderation Reporter");
        long postId = communityService.create("moderation-owner", "GENERAL", "관리 대상 게시글", "본문", null);

        communityService.reportPost("moderation-reporter", postId, "게시글 신고");
        long postReportId = jdbc.queryForObject("SELECT id FROM JL_COMMUNITY_REPORT WHERE post_id=?", Long.class, postId);
        communityService.moderateReport("moderation-owner", postReportId, "HIDE");
        assertThat(jdbc.queryForObject("SELECT status FROM JL_COMMUNITY_POST WHERE id=?", String.class, postId)).isEqualTo("HIDDEN");
        assertThat(jdbc.queryForObject("SELECT status FROM JL_COMMUNITY_REPORT WHERE id=?", String.class, postReportId)).isEqualTo("RESOLVED");

        long commentPostId = communityService.create("moderation-owner", "GENERAL", "관리 대상 댓글 게시글", "본문", null);
        communityService.comment("moderation-owner", commentPostId, "관리 대상 댓글");
        long commentId = ((Number) communityService.comments(commentPostId).get(0).get("ID")).longValue();
        communityService.reportComment("moderation-reporter", commentId, "댓글 신고");
        long commentReportId = jdbc.queryForObject("SELECT id FROM JL_COMMUNITY_REPORT WHERE comment_id=?", Long.class, commentId);
        communityService.moderateReport("moderation-owner", commentReportId, "DELETE");
        assertThat(jdbc.queryForObject("SELECT status FROM JL_COMMUNITY_COMMENT WHERE id=?", String.class, commentId)).isEqualTo("DELETED");
        assertThat(jdbc.queryForObject("SELECT status FROM JL_COMMUNITY_REPORT WHERE id=?", String.class, commentReportId)).isEqualTo("RESOLVED");
        assertThat(jdbc.queryForObject("SELECT COUNT(*) FROM JL_COMMUNITY_REPORT_AUDIT WHERE report_id IN (?,?)", Integer.class, postReportId, commentReportId)).isEqualTo(2);
    }

    @Test void processedCommunityReportCannotBeModeratedAgain() {
        memberService.register("processed-report-owner", "password123", "Processed Report Owner");
        memberService.register("processed-report-user", "password123", "Processed Report User");
        long postId = communityService.create("processed-report-owner", "GENERAL", "처리 완료 신고", "본문", null);
        communityService.reportPost("processed-report-user", postId, "신고 사유");
        long reportId = jdbc.queryForObject("SELECT id FROM JL_COMMUNITY_REPORT WHERE post_id=?", Long.class, postId);

        communityService.moderateReport("processed-report-owner", reportId, "REJECT");
        Throwable error = org.assertj.core.api.Assertions.catchThrowable(() -> communityService.moderateReport("processed-report-owner", reportId, "HIDE"));
        assertThat(error).isInstanceOf(org.springframework.web.server.ResponseStatusException.class);
        assertThat(((org.springframework.web.server.ResponseStatusException) error).getStatusCode().value()).isEqualTo(409);
        assertThat(jdbc.queryForObject("SELECT status FROM JL_COMMUNITY_REPORT WHERE id=?", String.class, reportId)).isEqualTo("REJECTED");
        assertThat(jdbc.queryForObject("SELECT status FROM JL_COMMUNITY_POST WHERE id=?", String.class, postId)).isEqualTo("ACTIVE");
    }

    @Test void missingAdministrativeTargetsReturn404() {
        memberService.register("missing-target-admin", "password123", "Missing Target Admin");
        assertThatThrownBy(() -> communityService.updatePostStatus(999999L, "HIDDEN"))
            .isInstanceOfSatisfying(org.springframework.web.server.ResponseStatusException.class,
                error -> assertThat(error.getStatusCode().value()).isEqualTo(404));
        assertThatThrownBy(() -> communityService.moderateReport("missing-target-admin", 999999L, "REJECT"))
            .isInstanceOfSatisfying(org.springframework.web.server.ResponseStatusException.class,
                error -> assertThat(error.getStatusCode().value()).isEqualTo(404));
        assertThatThrownBy(() -> adminContentService.togglePublished("999999"))
            .isInstanceOfSatisfying(org.springframework.web.server.ResponseStatusException.class,
                error -> assertThat(error.getStatusCode().value()).isEqualTo(404));
    }

    @Test void languageLinksPreserveCurrentFilters() throws Exception {
        mvc.perform(get("/procedures").param("q", "전입").param("phase", "AFTER_ARRIVAL").param("lang", "ko"))
            .andExpect(status().isOk())
            .andExpect(model().attribute("languageLinks", org.hamcrest.Matchers.hasEntry("en", "/procedures?q=%EC%A0%84%EC%9E%85&phase=AFTER_ARRIVAL&lang=en")));
    }

    @Test void notificationUnreadCountAndMarkAllReadWorks() {
        memberService.register("notif-author", "password123", "Notif Author");
        memberService.register("notif-commenter", "password123", "Notif Commenter");
        long postId = communityService.create("notif-author", "GENERAL", "알림 테스트 글", "내용", null);
        communityService.comment("notif-commenter", postId, "알림 댓글");

        assertThat(communityService.unreadNotificationCount("notif-author")).isGreaterThanOrEqualTo(1);
        communityService.markAllNotificationsRead("notif-author");
        assertThat(communityService.unreadNotificationCount("notif-author")).isEqualTo(0);
    }

    @Test void adminProcedureAndDocumentTranslationsCanBeSavedAndRetrieved() {
        adminContentService.saveProcedureTranslation(1L, "ko", "테스트 절차 제목", "테스트 절차 요약", "테스트 대상", "14일 이내", "창구 방문", "주의사항");
        var procTrans = adminContentService.procedureTranslations(1L);
        assertThat(procTrans).containsKey("ko");
        assertThat(procTrans.get("ko").get("title")).isEqualTo("테스트 절차 제목");
        assertThat(procTrans.get("ko").get("summary")).isEqualTo("테스트 절차 요약");

        adminContentService.saveDocumentTranslation(1L, "ko", "테스트 서류명", "테스트 조건문");
        var docTrans = adminContentService.documentTranslations(1L);
        assertThat(docTrans).containsKey("ko");
        assertThat(docTrans.get("ko").get("name")).isEqualTo("테스트 서류명");
        assertThat(docTrans.get("ko").get("condition_text")).isEqualTo("테스트 조건문");
    }
}
