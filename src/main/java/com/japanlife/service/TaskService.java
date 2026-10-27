package com.japanlife.service;

import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.japanlife.dto.*;
import com.japanlife.mapper.MemberMapper;
import com.japanlife.mapper.TaskMapper;

@Service
public class TaskService {
    private final TaskMapper tasks; private final MemberMapper members; private final ProcedureService procedures;
    public TaskService(TaskMapper tasks, MemberMapper members, ProcedureService procedures) { this.tasks = tasks; this.members = members; this.procedures = procedures; }
    private long memberId(String loginId) { Member m = members.findByLoginId(loginId); if (m == null) throw new IllegalStateException("member not found"); return m.getId(); }
    public List<UserTask> list(String loginId) { return list(loginId, "ja"); }
    public List<UserTask> list(String loginId, String language) { return tasks.findAllByMember(memberId(loginId), normalizedLanguage(language)); }
    public UserTask get(String loginId, long id) { return get(loginId, id, "ja"); }
    public UserTask get(String loginId, long id, String language) {
        UserTask task = tasks.findByIdAndMember(id, memberId(loginId), normalizedLanguage(language));
        if (task == null) return null;
        task.setChecks(tasks.findChecks(id, normalizedLanguage(language))); return task;
    }
    @Transactional
    public UserTask save(String loginId, long procedureId) { return save(loginId, procedureId, "ja"); }
    @Transactional
    public UserTask save(String loginId, long procedureId, String language) {
        long memberId = memberId(loginId);
        UserTask existing = tasks.findByProcedureAndMember(procedureId, memberId);
        if (existing != null) return existing;
        Procedure p = procedures.detail(procedureId, language);
        UserTask task = new UserTask(); task.setMemberId(memberId); task.setProcedureId(procedureId); task.setSavedRevision(p.getRevision()); task.setSavedTitle(p.getTitle());
        tasks.insertTask(task);
        int order = 1; for (RequiredDocument d : procedures.documents(procedureId, language)) {
            UserCheck check = new UserCheck(); check.setTaskId(task.getId()); check.setDocumentName(d.getName()); check.setRequirement(d.getRequirement()); check.setConditionText(d.getConditionText()); check.setDisplayOrder(order++); tasks.insertCheck(check);
        }
        return get(loginId, task.getId(), language);
    }
    @Transactional public boolean updateCheck(String loginId, long taskId, long checkId, boolean checked) {
        long memberId = memberId(loginId);
        if (tasks.findByIdAndMember(taskId, memberId, "ja") == null) return false;
        if (tasks.updateCheck(checkId, taskId, checked ? "Y" : "N") == 0) return false;
        updateTaskStatus(taskId, memberId, tasks.findChecks(taskId, "ja"));
        return true;
    }
    @Transactional public boolean saveChecks(String loginId, long taskId, List<Long> checkedIds) {
        long memberId = memberId(loginId);
        UserTask task = tasks.findByIdAndMember(taskId, memberId, "ja");
        if (task == null) return false;
        List<UserCheck> checks = tasks.findChecks(taskId, "ja");
        Set<Long> selected = checkedIds == null ? Set.of() : new HashSet<>(checkedIds);
        for (UserCheck check : checks) {
            boolean checked = selected.contains(check.getId());
            tasks.updateCheck(check.getId(), taskId, checked ? "Y" : "N");
        }
        updateTaskStatus(taskId, memberId, tasks.findChecks(taskId, "ja"));
        return true;
    }
    public List<TaskEvent> events(String loginId, YearMonth month) { return events(loginId, month, "ja"); }
    public List<TaskEvent> events(String loginId, YearMonth month, String language) {
        LocalDate from = month.atDay(1).minusDays(month.atDay(1).getDayOfWeek().getValue() % 7);
        LocalDate to = from.plusDays(42);
        return tasks.findEvents(memberId(loginId), from.toString(), to.toString(), normalizedLanguage(language));
    }
    @Transactional
    public TaskEvent addEvent(String loginId, long taskId, String eventDate, String title, String memo) {
        long memberId = memberId(loginId);
        if (tasks.findByIdAndMember(taskId, memberId, "ja") == null) throw new IllegalArgumentException("task not found");
        if (eventDate == null || eventDate.isBlank()) throw new IllegalArgumentException("invalid event date");
        try {
            LocalDate.parse(eventDate, DateTimeFormatter.ISO_LOCAL_DATE);
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("invalid event date", e);
        }
        String cleanTitle = title == null ? "" : title.strip();
        if (cleanTitle.isBlank() || cleanTitle.length() > 200) throw new IllegalArgumentException("invalid event title");
        String cleanMemo = memo == null ? null : memo.strip();
        if (cleanMemo != null && cleanMemo.length() > 1000) throw new IllegalArgumentException("invalid event memo");
        TaskEvent event = new TaskEvent(); event.setTaskId(taskId); event.setMemberId(memberId);
        event.setEventDate(eventDate); event.setTitle(cleanTitle); event.setMemo(cleanMemo);
        tasks.insertEvent(event); return event;
    }
    @Transactional public boolean toggleEvent(String loginId, long eventId) {
        long memberId = memberId(loginId); TaskEvent event = tasks.findEventByIdAndMember(eventId, memberId);
        if (event == null) return false;
        return tasks.updateEventCompleted(eventId, memberId, "Y".equals(event.getCompleted()) ? "N" : "Y") > 0;
    }
    @Transactional public boolean deleteEvent(String loginId, long eventId) {
        return tasks.deleteEvent(eventId, memberId(loginId)) > 0;
    }
    @Transactional
    public boolean delete(String loginId, long taskId) {
        long memberId = memberId(loginId);
        if (tasks.findByIdAndMember(taskId, memberId, "ja") == null) return false;
        tasks.deleteEventsByTask(taskId, memberId);
        tasks.deleteChecksByTask(taskId);
        return tasks.deleteTask(taskId, memberId) > 0;
    }
    public List<CalendarDay> calendarDays(YearMonth month, LocalDate selected, List<TaskEvent> events) {
        LocalDate first = month.atDay(1);
        LocalDate start = first.minusDays(first.getDayOfWeek().getValue() % 7);
        Map<String, Integer> counts = new HashMap<>();
        for (TaskEvent event : events) counts.merge(event.getEventDate(), 1, Integer::sum);
        List<CalendarDay> days = new ArrayList<>();
        for (int i = 0; i < 42; i++) {
            LocalDate date = start.plusDays(i);
            days.add(new CalendarDay(date.toString(), date.getDayOfMonth(), date.getMonthValue() == month.getMonthValue(),
                date.equals(LocalDate.now()), date.equals(selected), counts.getOrDefault(date.toString(), 0)));
        }
        return days;
    }
    public List<TaskEvent> eventsOn(List<TaskEvent> events, LocalDate date) {
        return events.stream().filter(event -> date.toString().equals(event.getEventDate())).toList();
    }
    private void updateTaskStatus(long taskId, long memberId, List<UserCheck> checks) {
        long checkedCount = checks.stream().filter(check -> "Y".equals(check.getChecked())).count();
        String status = checkedCount == 0 ? "NOT_STARTED"
                : checkedCount == checks.size() ? "COMPLETED" : "PREPARING";
        if (tasks.updateStatus(taskId, memberId, status) == 0) {
            throw new IllegalStateException("task status update failed");
        }
    }
    private String normalizedLanguage(String language) { return "ko".equals(language) || "en".equals(language) ? language : "ja"; }
}
