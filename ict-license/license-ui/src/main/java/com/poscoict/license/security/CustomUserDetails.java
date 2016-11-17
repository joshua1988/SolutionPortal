package com.poscoict.license.security;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomUserDetails implements UserDetails {

	private static final long serialVersionUID = -7977132560233286417L;
	private String userno;
	private String username;
	private String password;
	private boolean changePassword;
	private Collection<? extends GrantedAuthority> authorities;
	
	public CustomUserDetails(String userno, String password, String username, boolean changePassword, Collection<? extends GrantedAuthority> authorities){
		this.userno = userno;
		this.password = password;
		this.username = username;
		this.changePassword = changePassword;
		this.authorities = authorities;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
	}

	public String getPassword() {
		return password;
	}
	
	public String setPassword(String password) {
		return this.password=password;
	}
	
	public String getUserNo() {
		return userno;
	}

	public String getUsername() {
		return username;
	}
	
	public boolean changePassword() {
		return this.changePassword;
	}
	
	public boolean setChangePassword(boolean changePassword) {
		return this.changePassword=changePassword;
	}

	public boolean isAccountNonExpired() {
		return true;
	}

	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	public boolean isEnabled() {
		return true;
	}

}
