package com.gozoo.vo;

public class MessageVO {
	private String sender;
	private String m_content;
	private String m_date;
	private int m_id;
	private String sender_img;
	
	
	public MessageVO(){};
	public MessageVO(String sender) {
		this.sender = sender;
	}
	public MessageVO(String sender, String m_content, String m_date,int m_id,String sender_img) {
		this.sender = sender;
		this.m_content = m_content;
		this.m_date = m_date;
		this.m_id = m_id;
		this.sender_img = sender_img;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
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
	public int getM_id() {
		return m_id;
	}
	public void setM_id(int m_id) {
		this.m_id = m_id;
	}
	public String getSender_img() {
		return sender_img;
	}
	public void setSender_img(String sender_img) {
		this.sender_img = sender_img;
	}
	
	
	
	
}
