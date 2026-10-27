package com.japanlife.service;

import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Map;
import com.japanlife.dto.Member;
import com.japanlife.mapper.MemberMapper;

@Service
public class MemberService {
    private final MemberMapper mapper;
    private final PasswordEncoder passwordEncoder;
    public MemberService(MemberMapper mapper, PasswordEncoder passwordEncoder) {
        this.mapper = mapper; this.passwordEncoder = passwordEncoder;
    }
    public Member findByLoginId(String loginId) { return mapper.findByLoginId(loginId); }
    public Member findByEmail(String email) { return mapper.findByEmail(email); }
    public Member findById(long id) { return mapper.findById(id); }
    public List<Member> listForAdmin() { return mapper.findAllForAdmin(); }
    public boolean isLoginIdAvailable(String loginId) {
        return loginId != null && mapper.findByLoginId(loginId) == null;
    }
    public boolean isEmailAvailable(String email) {
        return email != null && mapper.findByEmail(email) == null;
    }
    public boolean matchesPassword(Member member, String rawPassword) {
        return member != null && rawPassword != null && passwordEncoder.matches(rawPassword, member.getPasswordHash());
    }
    @Transactional
    public void updateDisplayName(long memberId, String displayName) {
        mapper.updateDisplayName(memberId, displayName);
    }
    @Transactional
    public void updatePassword(long memberId, String rawPassword) {
        mapper.updatePasswordHash(memberId, passwordEncoder.encode(rawPassword));
    }
    @Transactional
    public boolean updateRole(long memberId, String role) {
        if (!"MEMBER".equals(role) && !"ADMIN".equals(role)) return false;
        return mapper.updateRole(memberId, role) > 0;
    }
    @Transactional
    public boolean updateRole(long memberId, String role, long adminMemberId, String reason) {
        Member target = mapper.findById(memberId);
        if (target == null || !("MEMBER".equals(role) || "ADMIN".equals(role))) return false;
        if (mapper.updateRole(memberId, role) == 0) return false;
        mapper.insertMemberAudit(memberId, adminMemberId, "ROLE_CHANGE", target.getRole(), role,
                reason == null || reason.isBlank() ? "Admin role change" : reason.trim());
        return true;
    }
    @Transactional
    public boolean updateStatus(long memberId, String status) {
        if (!"ACTIVE".equals(status) && !"INACTIVE".equals(status)) return false;
        return mapper.updateStatus(memberId, status) > 0;
    }
    @Transactional
    public boolean updateStatus(long memberId, String status, long adminMemberId, String reason) {
        Member target = mapper.findById(memberId);
        if (target == null || !"ACTIVE".equals(status) && !"INACTIVE".equals(status)) return false;
        if (mapper.updateStatus(memberId, status) == 0) return false;
        mapper.insertMemberAudit(memberId, adminMemberId, "STATUS_CHANGE", target.getStatus(), status,
                reason == null || reason.isBlank() ? "Admin status change" : reason.trim());
        return true;
    }
    public List<Map<String, Object>> audit() {
        return mapper.findAudits();
    }
    @Transactional
    public void register(String loginId, String password, String displayName) {
        register(loginId, password, displayName, null);
    }
    @Transactional
    public void register(String loginId, String password, String displayName, String email) {
        if (mapper.findByLoginId(loginId) != null) throw new DataIntegrityViolationException("duplicate login id");
        if (email != null && mapper.findByEmail(email) != null) throw new DataIntegrityViolationException("duplicate email");
        Member member = new Member(); member.setLoginId(loginId); member.setPasswordHash(passwordEncoder.encode(password));
        member.setDisplayName(displayName); member.setRole("MEMBER"); member.setEmail(email); member.setEmailVerified(email == null ? "N" : "Y"); mapper.insert(member);
    }
}
