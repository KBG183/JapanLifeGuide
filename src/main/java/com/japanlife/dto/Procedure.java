package com.japanlife.dto;

public class Procedure {
    private Long id;
    private String title;
    private String summary;
    private String eligibility;
    private String deadlineText;
    private String methodText;
    private String notice;
    private String situation;
    private String phaseCode;
    private String regionName;
    private String categoryName;
    private Long regionId;
    private Long categoryId;
    private Integer revision;
    private Integer documentCount;
    private Integer stepCount;
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    public String getEligibility() { return eligibility; }
    public void setEligibility(String eligibility) { this.eligibility = eligibility; }
    public String getDeadlineText() { return deadlineText; }
    public void setDeadlineText(String deadlineText) { this.deadlineText = deadlineText; }
    public String getMethodText() { return methodText; }
    public void setMethodText(String methodText) { this.methodText = methodText; }
    public String getNotice() { return notice; }
    public void setNotice(String notice) { this.notice = notice; }
    public String getSituation() { return situation; }
    public void setSituation(String situation) { this.situation = situation; }
    public String getPhaseCode() { return phaseCode; }
    public void setPhaseCode(String phaseCode) { this.phaseCode = phaseCode; }
    public String getRegionName() { return regionName; }
    public void setRegionName(String regionName) { this.regionName = regionName; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public Long getRegionId() { return regionId; }
    public void setRegionId(Long regionId) { this.regionId = regionId; }
    public Long getCategoryId() { return categoryId; }
    public void setCategoryId(Long categoryId) { this.categoryId = categoryId; }
    public Integer getRevision() { return revision; }
    public void setRevision(Integer revision) { this.revision = revision; }
    public Integer getDocumentCount() { return documentCount; }
    public void setDocumentCount(Integer documentCount) { this.documentCount = documentCount; }
    public Integer getStepCount() { return stepCount; }
    public void setStepCount(Integer stepCount) { this.stepCount = stepCount; }
}
