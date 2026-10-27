package com.japanlife.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.japanlife.dto.Member;
import com.japanlife.dto.EmailVerification;
import com.japanlife.dto.PasswordReset;
import java.util.List;

@Mapper
public interface MemberMapper {
    Member findByLoginId(@Param("loginId") String loginId);
    Member findByEmail(@Param("email") String email);
    Member findByLoginIdAndEmail(@Param("loginId") String loginId, @Param("email") String email);
    Member findById(@Param("id") long id);
    List<Member> findAllForAdmin();
    void insert(Member member);
    void insertEmailVerification(EmailVerification verification);
    EmailVerification findLatestEmailVerification(@Param("email") String email);
    int markEmailVerificationVerified(@Param("id") long id, @Param("verifiedAt") java.time.LocalDateTime verifiedAt);
    int incrementEmailVerificationAttempts(@Param("id") long id);
    void insertPasswordReset(PasswordReset reset);
    PasswordReset findLatestPasswordReset(@Param("memberId") long memberId);
    int incrementPasswordResetAttempts(@Param("id") long id);
    int markPasswordResetVerified(@Param("id") long id, @Param("verifiedAt") java.time.LocalDateTime verifiedAt);
    int updatePasswordHash(@Param("memberId") long memberId, @Param("passwordHash") String passwordHash);
    int updateDisplayName(@Param("memberId") long memberId, @Param("displayName") String displayName);
    int updateRole(@Param("memberId") long memberId, @Param("role") String role);
    int updateStatus(@Param("memberId") long memberId, @Param("status") String status);
    void insertMemberAudit(@Param("memberId") long memberId, @Param("adminMemberId") long adminMemberId, @Param("actionType") String actionType, @Param("previousStatus") String previousStatus, @Param("newStatus") String newStatus, @Param("reason") String reason);
    List<java.util.Map<String, Object>> findAudits();
}
