package com.japanlife.service;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.http.HttpStatus;
import org.springframework.web.server.ResponseStatusException;
import com.japanlife.dto.Member;
import com.japanlife.mapper.CommunityMapper;

@Service
public class CommunityService {
    private static final List<String> CATEGORIES = List.of("ADMIN", "HOME", "STUDENT", "WORK", "MEETUP", "GENERAL");
    private static final List<String> TYPES = List.of("image/jpeg", "image/png", "image/gif", "image/webp");
    private final CommunityMapper mapper;
    private final MemberService members;
    private final Path uploadDir = Path.of("community-uploads").toAbsolutePath().normalize();

    public CommunityService(CommunityMapper mapper, MemberService members) {
        this.mapper = mapper;
        this.members = members;
    }

    public List<Map<String, Object>> posts(String category) {
        return posts(category, "");
    }

    public List<Map<String, Object>> posts(String category, String query) {
        return posts(category, query, 1, 10);
    }

    public List<Map<String, Object>> posts(String category, String query, int page, int pageSize) {
        if (page < 1 || pageSize < 1) {
            throw new IllegalArgumentException("page");
        }
        Filter filter = filter(category, query);
        int offset = (page - 1) * pageSize;
        return mapper.findPosts(filter.category(), filter.query(), offset, pageSize);
    }

    public int countPosts(String category, String query) {
        Filter filter = filter(category, query);
        return mapper.countPosts(filter.category(), filter.query());
    }

    private Filter filter(String category, String query) {
        String normalizedCategory = category == null || !CATEGORIES.contains(category) ? "" : category;
        String normalizedQuery = query == null ? "" : query.strip();
        if (normalizedQuery.length() > 80) {
            throw new IllegalArgumentException("query");
        }
        return new Filter(normalizedCategory, normalizedQuery);
    }

    private record Filter(String category, String query) {}

    @Transactional
    public Map<String, Object> post(long id) {
        if (mapper.updateViewCount(id) == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        Map<String, Object> post = mapper.findPostById(id);
        if (post == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        return post;
    }

    public Map<String, Object> editablePost(String login, long id) {
        Member member = member(login);
        Map<String, Object> post = mapper.findEditablePost(id, member.getId());
        if (post == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        return post;
    }

    public List<Map<String, Object>> comments(long postId) {
        return mapper.findComments(postId);
    }

    public List<Map<String, Object>> images(long postId) {
        return mapper.findImages(postId);
    }

    private Member member(String login) {
        Member member = members.findByLoginId(login);
        if (member == null) {
            throw new IllegalArgumentException("member");
        }
        return member;
    }

    public long memberId(String login) {
        return member(login).getId();
    }

    public boolean bookmarkedBy(String login, long postId) {
        Member member = member(login);
        Integer count = mapper.findBookmarkCount(member.getId(), postId);
        return count != null && count > 0;
    }

    @Transactional
    public boolean bookmark(String login, long postId) {
        requireActivePost(postId);
        Member member = member(login);
        int deleted = mapper.deleteBookmark(member.getId(), postId);
        if (deleted == 0) mapper.insertBookmark(member.getId(), postId);
        return deleted == 0;
    }

    public List<Map<String, Object>> bookmarks(String login) {
        Member member = member(login);
        return mapper.findBookmarks(member.getId());
    }

    private String text(String value, int max) {
        String cleaned = value == null ? "" : value.strip();
        if (cleaned.isBlank() || cleaned.length() > max) {
            throw new IllegalArgumentException("text");
        }
        return cleaned;
    }

    @Transactional
    public long create(String login, String category, String title, String body, MultipartFile[] files) {
        if (!CATEGORIES.contains(category)) {
            throw new IllegalArgumentException("category");
        }
        Member member = member(login);
        title = text(title, 200);
        body = text(body, 10000);
        validateImages(files);
        long id = mapper.getNextPostId();
        mapper.insertPost(id, member.getId(), category, title, body);
        saveImages(id, files);
        return id;
    }

    @Transactional
    public void comment(String login, long postId, String body) {
        requireActivePost(postId);
        Member member = member(login);
        body = text(body, 3000);
        mapper.insertComment(postId, member.getId(), body);
        Long ownerId = mapper.findPostOwnerId(postId);
        if (ownerId != null && ownerId.longValue() != member.getId()) {
            mapper.insertNotification(ownerId, "COMMENT", postId, "A new comment was posted on your community post.");
        }
    }

    @Transactional
    public boolean like(String login, long postId) {
        requireActivePost(postId);
        Member member = member(login);
        int deleted = mapper.deleteLike(postId, member.getId());
        if (deleted == 0) {
            mapper.insertLike(postId, member.getId());
        }
        return deleted == 0;
    }

    public int likeCount(long postId) {
        Integer count = mapper.findLikeCount(postId);
        return count != null ? count : 0;
    }

    public boolean likedBy(String login, long postId) {
        Member member = member(login);
        Integer count = mapper.findUserLikeCount(postId, member.getId());
        return count != null && count > 0;
    }

    @Transactional
    public void updatePost(String login, long id, String category, String title, String body) {
        Member member = member(login);
        if (!CATEGORIES.contains(category)) {
            throw new IllegalArgumentException("category");
        }
        if (mapper.updatePost(id, member.getId(), category, text(title, 200), text(body, 10000)) == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    @Transactional
    public void updateComment(String login, long id, long postId, String body) {
        Member member = member(login);
        requireActivePost(postId);
        if (mapper.updateComment(id, postId, member.getId(), text(body, 3000)) == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    public int unreadNotificationCount(String login) {
        Member member = members.findByLoginId(login);
        if (member == null) return 0;
        Integer count = mapper.findUnreadNotificationCount(member.getId());
        return count != null ? count : 0;
    }

    public List<Map<String, Object>> notifications(String login) {
        Member member = member(login);
        return mapper.findNotifications(member.getId());
    }

    @Transactional
    public void markNotificationRead(String login, long id) {
        Member member = member(login);
        mapper.markNotificationRead(id, member.getId());
    }

    @Transactional
    public void markAllNotificationsRead(String login) {
        Member member = member(login);
        mapper.markAllNotificationsRead(member.getId());
    }

    private void deleteDiskImages(long postId) {
        List<String> storedNames = mapper.findStoredImageNames(postId);
        for (String name : storedNames) {
            try {
                Path path = uploadDir.resolve(name).normalize();
                if (path.startsWith(uploadDir)) {
                    Files.deleteIfExists(path);
                }
            } catch (IOException ignored) {}
        }
    }

    @Transactional
    public void deletePost(String login, long id) {
        Member member = member(login);
        if (mapper.deletePost(id, member.getId()) == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        deleteDiskImages(id);
    }

    @Transactional
    public void deleteComment(String login, long id) {
        Member member = member(login);
        if (mapper.deleteComment(id, member.getId()) == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    @Transactional
    public void reportPost(String login, long id, String reason) {
        requireActivePost(id);
        Member member = member(login);
        String normalizedReason = text(reason, 500);
        Integer ownerCount = mapper.countPostOwner(id, member.getId());
        if (ownerCount != null && ownerCount > 0) throw new IllegalArgumentException("own post");
        Integer reportCount = mapper.countOpenPostReports(id, member.getId());
        if (reportCount == null || reportCount == 0) {
            mapper.insertPostReport(id, member.getId(), normalizedReason);
        }
    }

    @Transactional
    public void reportComment(String login, long id, String reason) {
        Integer count = mapper.countActiveCommentOnActivePost(id);
        if (count == null || count == 0) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        Member member = member(login);
        String normalizedReason = text(reason, 500);
        Integer ownerCount = mapper.countCommentOwner(id, member.getId());
        if (ownerCount != null && ownerCount > 0) throw new IllegalArgumentException("own comment");
        Integer reportCount = mapper.countOpenCommentReports(id, member.getId());
        if (reportCount == null || reportCount == 0) {
            mapper.insertCommentReport(id, member.getId(), normalizedReason);
        }
    }

    public List<Map<String, Object>> reports() {
        return mapper.findReports();
    }

    public List<Map<String, Object>> adminPosts(String category, String query) {
        Filter filter = filter(category, query);
        return mapper.findAdminPosts(filter.category(), filter.query());
    }

    @Transactional
    public void updatePostStatus(long id, String status) {
        if (!List.of("ACTIVE", "HIDDEN", "DELETED").contains(status)) {
            throw new IllegalArgumentException("status");
        }
        if (mapper.updatePostStatus(id, status) == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        if ("DELETED".equals(status)) {
            deleteDiskImages(id);
        }
    }

    @Transactional
    public void moderateReport(String adminLogin, long id, String action) {
        if (!List.of("REJECT", "HIDE", "DELETE").contains(action)) {
            throw new IllegalArgumentException("action");
        }
        Member admin = member(adminLogin);
        Map<String, Object> report = mapper.findReportById(id);
        if (report == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        String status = (String) report.get("STATUS");
        if (status == null) status = (String) report.get("status");
        if (!"OPEN".equals(status)) {
            throw new ResponseStatusException(HttpStatus.CONFLICT);
        }
        Number postId = (Number) (report.get("POST_ID") != null ? report.get("POST_ID") : report.get("post_id"));
        Number commentId = (Number) (report.get("COMMENT_ID") != null ? report.get("COMMENT_ID") : report.get("comment_id"));
        String targetType = commentId != null ? "COMMENT" : "POST";
        String previousContentStatus;
        if (commentId != null) {
            previousContentStatus = mapper.findCommentStatus(commentId.longValue());
        } else if (postId != null) {
            previousContentStatus = mapper.findPostStatus(postId.longValue());
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        if (previousContentStatus == null) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        if ("REJECT".equals(action)) {
            mapper.updateReportStatus(id, "REJECTED");
            mapper.insertReportAudit(id, admin.getId(), action, "OPEN", "REJECTED", targetType, previousContentStatus, previousContentStatus);
            return;
        }
        String contentStatus = "HIDE".equals(action) ? "HIDDEN" : "DELETED";
        if (commentId != null) {
            if (mapper.updateCommentStatus(commentId.longValue(), contentStatus) == 0) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND);
            }
        } else if (postId != null) {
            if (mapper.updatePostStatus(postId.longValue(), contentStatus) == 0) {
                throw new ResponseStatusException(HttpStatus.NOT_FOUND);
            }
            if ("DELETE".equals(action)) {
                deleteDiskImages(postId.longValue());
            }
        } else {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
        mapper.updateReportStatus(id, "RESOLVED");
        mapper.insertReportAudit(id, admin.getId(), action, "OPEN", "RESOLVED", targetType, previousContentStatus, contentStatus);
    }

    private void saveImages(long postId, MultipartFile[] files) {
        if (files == null) {
            return;
        }
        try {
            Files.createDirectories(uploadDir);
            int order = 1;
            for (MultipartFile file : files) {
                if (file == null || file.isEmpty()) {
                    continue;
                }
                String originalName = file.getOriginalFilename() == null || file.getOriginalFilename().isBlank()
                        ? "image" : Path.of(file.getOriginalFilename()).getFileName().toString();
                originalName = text(originalName, 255);
                String stored = UUID.randomUUID() + extension(file.getContentType());
                Path target = uploadDir.resolve(stored).normalize();
                if (!target.startsWith(uploadDir)) {
                    throw new IllegalArgumentException("image");
                }
                try (var input = file.getInputStream()) {
                    Files.copy(input, target, StandardCopyOption.REPLACE_EXISTING);
                }
                mapper.insertImage(postId, originalName, stored, file.getContentType(), file.getSize(), order++);
            }
        } catch (IOException e) {
            throw new IllegalStateException("image", e);
        }
    }

    private void validateImages(MultipartFile[] files) {
        if (files == null) return;
        long imageCount = java.util.Arrays.stream(files).filter(file -> file != null && !file.isEmpty()).count();
        if (imageCount > 5) throw new IllegalArgumentException("image count");
        try {
            for (MultipartFile file : files) {
                if (file != null && !file.isEmpty()
                        && (file.getSize() > 5_000_000 || !TYPES.contains(file.getContentType()) || !isRecognizedImage(file))) {
                    throw new IllegalArgumentException("image");
                }
            }
        } catch (IOException e) {
            throw new IllegalStateException("image", e);
        }
    }

    public Path image(String stored) {
        Integer visible = mapper.countVisibleImage(stored);
        if (visible == null || visible == 0) {
            return null;
        }
        Path path = uploadDir.resolve(stored).normalize();
        return path.startsWith(uploadDir) ? path : null;
    }

    private void requireActivePost(long postId) {
        Integer count = mapper.countActivePosts(postId);
        if (count == null || count == 0) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
    }

    private boolean isRecognizedImage(MultipartFile file) throws IOException {
        byte[] header;
        try (var input = file.getInputStream()) {
            header = input.readNBytes(12);
        }
        if (header.length < 4) return false;
        String type = file.getContentType();
        if ("image/jpeg".equals(type)) return (header[0] & 0xff) == 0xff && (header[1] & 0xff) == 0xd8 && (header[2] & 0xff) == 0xff;
        if ("image/png".equals(type)) return (header[0] & 0xff) == 0x89 && header[1] == 0x50 && header[2] == 0x4e && header[3] == 0x47;
        if ("image/gif".equals(type)) return new String(header, 0, Math.min(6, header.length), java.nio.charset.StandardCharsets.US_ASCII).startsWith("GIF8");
        return "image/webp".equals(type) && header.length >= 12
                && new String(header, 0, 4, java.nio.charset.StandardCharsets.US_ASCII).equals("RIFF")
                && new String(header, 8, 4, java.nio.charset.StandardCharsets.US_ASCII).equals("WEBP");
    }

    private String extension(String contentType) {
        return switch (contentType) {
            case "image/jpeg" -> ".jpg";
            case "image/png" -> ".png";
            case "image/gif" -> ".gif";
            case "image/webp" -> ".webp";
            default -> throw new IllegalArgumentException("image");
        };
    }
}
