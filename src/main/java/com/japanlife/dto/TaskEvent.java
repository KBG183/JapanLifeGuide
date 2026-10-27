package com.japanlife.dto;

public class TaskEvent {
    private Long id;
    private Long taskId;
    private Long memberId;
    private String eventDate;
    private String title;
    private String memo;
    private String completed;
    private String taskTitle;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getTaskId() { return taskId; }
    public void setTaskId(Long taskId) { this.taskId = taskId; }
    public Long getMemberId() { return memberId; }
    public void setMemberId(Long memberId) { this.memberId = memberId; }
    public String getEventDate() { return eventDate; }
    public void setEventDate(String eventDate) { this.eventDate = eventDate; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getMemo() { return memo; }
    public void setMemo(String memo) { this.memo = memo; }
    public String getCompleted() { return completed; }
    public void setCompleted(String completed) { this.completed = completed; }
    public String getTaskTitle() { return taskTitle; }
    public void setTaskTitle(String taskTitle) { this.taskTitle = taskTitle; }
}
