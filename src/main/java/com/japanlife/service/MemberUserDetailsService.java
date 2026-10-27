package com.japanlife.service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.japanlife.dto.Member;

@Service
public class MemberUserDetailsService implements UserDetailsService {
    private final MemberService members;
    public MemberUserDetailsService(MemberService members) { this.members = members; }
    @Override public UserDetails loadUserByUsername(String username) {
        Member member = members.findByLoginId(username);
        if (member == null) throw new UsernameNotFoundException(username);
        return User.withUsername(member.getLoginId()).password(member.getPasswordHash()).roles(member.getRole()).disabled(!"ACTIVE".equals(member.getStatus())).build();
    }
}
