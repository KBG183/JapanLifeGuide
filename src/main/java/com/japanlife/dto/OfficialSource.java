package com.japanlife.dto;

public class OfficialSource {
    private Long id;
    private String title;
    private String url;
    private String checkedOn;
    private String updatedOn;
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }
    public String getCheckedOn() { return checkedOn; }
    public void setCheckedOn(String checkedOn) { this.checkedOn = checkedOn; }
    public String getUpdatedOn() { return updatedOn; }
    public void setUpdatedOn(String updatedOn) { this.updatedOn = updatedOn; }
}
