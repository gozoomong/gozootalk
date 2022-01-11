package com.gozoo.vo;

public class ChattingVO {
	
	public String m_content;
	public String m_date;
	public String m_id;
	public String m_w_email;
	public String m_w_profile;
	
	public ChattingVO(){};
	public ChattingVO(String m_content, String m_date,String m_w_email,String m_w_profile) {
		super();
		this.m_content = m_content;
		this.m_date = m_date;
		this.m_w_email = m_w_email;
		this.m_w_profile = m_w_profile;
	}
	public String getM_content() {
		return m_content;
	}
	public void setM_content(String m_content) {
		this.m_content = m_content;
	}
	public String getM_date() {
		return m_date;
	}
	public void setM_date(String m_date) {
		this.m_date = m_date;
	}
	public String getM_id() {
		return m_id;
	}
	public void setM_id(String m_id) {
		this.m_id = m_id;
	}
	
	
	
	public String getM_w_email() {
		return m_w_email;
	}
	public void setM_w_email(String m_w_email) {
		this.m_w_email = m_w_email;
	}
	
	
	
	public String getM_w_profile() {
		return m_w_profile;
	}
	public void setM_w_profile(String m_w_profile) {
		this.m_w_profile = m_w_profile;
	}
	
	
	
	
	

}
