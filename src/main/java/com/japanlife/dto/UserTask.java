package com.japanlife.dto;

import java.util.List;

public class UserTask {
    private Long id;
    private Long memberId;
    private Long procedureId;
    private Integer savedRevision;
    private Integer currentRevision;
    private String savedTitle;
    private String status;
    private String memo;
    private String visitDate;
    private String completedAt;
    private List<UserCheck> checks;
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getMemberId() { return memberId; }
    public void setMemberId(Long memberId) { this.memberId = memberId; }
    public Long getProcedureId() { return procedureId; }
    public void setProcedureId(Long procedureId) { this.procedureId = procedureId; }
    public Integer getSavedRevision() { return savedRevision; }
    public void setSavedRevision(Integer savedRevision) { this.savedRevision = savedRevision; }
    public Integer getCurrentRevision() { return currentRevision; }
    public void setCurrentRevision(Integer currentRevision) { this.currentRevision = currentRevision; }
    public String getSavedTitle() { return savedTitle; }
    public void setSavedTitle(String savedTitle) { this.savedTitle = savedTitle; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }
    public String getVisitDate() { return visitDate; }
    public void setVisitDate(String visitDate) { this.visitDate = visitDate; }
    public String getCompletedAt() { return completedAt; }
    public void setCompletedAt(String completedAt) { this.completedAt = completedAt; }
    public List<UserCheck> getChecks() { return checks; }
    public void setChecks(List<UserCheck> checks) { this.checks = checks; }
}
