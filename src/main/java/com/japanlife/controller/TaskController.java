package com.japanlife.controller;

import java.security.Principal;
import java.util.List;
import java.util.Locale;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.DateTimeException;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Map;
import java.util.LinkedHashMap;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import com.japanlife.service.TaskService;

@Controller
public class TaskController {
    private final TaskService tasks;
    public TaskController(TaskService tasks) { this.tasks = tasks; }
    @GetMapping("/my/tasks")
    public String list(Principal principal, Locale locale,
                       @RequestParam(required=false) Integer year,
                       @RequestParam(required=false) Integer month,
                       @RequestParam(required=false) String date,
                       Model model) {
        LocalDate today = LocalDate.now();
        LocalDate requestedDate = parseDate(date, today);
        YearMonth current = year == null && month == null ? YearMonth.from(requestedDate) : safeMonth(year, month);
        LocalDate selected = date == null || date.isBlank() ? current.atDay(1) : requestedDate;
        if (!selected.getMonth().equals(current.getMonth()) || selected.getYear() != current.getYear()) selected = current.atDay(1);
        var events = tasks.events(principal.getName(), current, locale.getLanguage());
        Map<String, List<com.japanlife.dto.TaskEvent>> eventsByDate = new LinkedHashMap<>();
        events.forEach(event -> eventsByDate.computeIfAbsent(event.getEventDate(), ignored -> new java.util.ArrayList<>()).add(event));
        model.addAttribute("tasks", tasks.list(principal.getName(), locale.getLanguage()));
        model.addAttribute("calendarDays", tasks.calendarDays(current, selected, events));
        model.addAttribute("eventsByDate", eventsByDate);
        model.addAttribute("selectedDate", selected.toString());
        model.addAttribute("monthLabel", current.toString());
        model.addAttribute("previousMonth", current.minusMonths(1).toString());
        model.addAttribute("nextMonth", current.plusMonths(1).toString());
        return "tasks/list";
    }
    @PostMapping("/my/tasks") public String save(@RequestParam long procedureId, Principal principal, Locale locale) { return "redirect:/my/tasks/" + tasks.save(principal.getName(), procedureId, locale.getLanguage()).getId(); }
    @PostMapping("/my/tasks/{taskId}/delete") public String delete(@PathVariable long taskId, Principal principal) {
        if (!tasks.delete(principal.getName(), taskId)) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return "redirect:/my/tasks?deleted";
    }
    @GetMapping("/my/tasks/{id}") public String detail(@PathVariable long id, Principal principal, Locale locale, Model model) { var task = tasks.get(principal.getName(), id, locale.getLanguage()); if (task == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND); model.addAttribute("task", task); return "tasks/detail"; }
    @PostMapping("/my/tasks/{taskId}/checks") public String saveChecks(@PathVariable long taskId, @RequestParam(name="checkedIds", required=false) List<Long> checkedIds, Principal principal) { if (!tasks.saveChecks(principal.getName(), taskId, checkedIds)) throw new ResponseStatusException(HttpStatus.NOT_FOUND); return "redirect:/my/tasks/" + taskId; }
    @PostMapping("/my/tasks/{taskId}/checks/{checkId}") public String check(@PathVariable long taskId, @PathVariable long checkId, @RequestParam(defaultValue="false") boolean checked, Principal principal) { if (!tasks.updateCheck(principal.getName(), taskId, checkId, checked)) throw new ResponseStatusException(HttpStatus.NOT_FOUND); return "redirect:/my/tasks/" + taskId; }
    @PostMapping("/my/events")
    public String addEvent(@RequestParam long taskId, @RequestParam String eventDate, @RequestParam String title,
                           @RequestParam(required=false) String memo, Principal principal) {
        try { tasks.addEvent(principal.getName(), taskId, eventDate, title, memo); }
        catch (IllegalArgumentException e) { throw new ResponseStatusException(HttpStatus.BAD_REQUEST); }
        return "redirect:/my/tasks?date=" + eventDate;
    }
    @PostMapping("/my/events/{eventId}/toggle")
    public String toggleEvent(@PathVariable long eventId, Principal principal) {
        if (!tasks.toggleEvent(principal.getName(), eventId)) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return "redirect:/my/tasks";
    }
    @PostMapping("/my/events/{eventId}/delete")
    public String deleteEvent(@PathVariable long eventId, Principal principal) {
        if (!tasks.deleteEvent(principal.getName(), eventId)) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return "redirect:/my/tasks";
    }
    private YearMonth safeMonth(Integer year, Integer month) {
        try { return YearMonth.of(year == null ? LocalDate.now().getYear() : year, month == null ? LocalDate.now().getMonthValue() : month); }
        catch (DateTimeException e) { throw new ResponseStatusException(HttpStatus.BAD_REQUEST); }
    }
    private LocalDate parseDate(String value, LocalDate fallback) {
        if (value == null || value.isBlank()) return fallback;
        try { return LocalDate.parse(value, DateTimeFormatter.ISO_LOCAL_DATE); }
        catch (DateTimeParseException e) { throw new ResponseStatusException(HttpStatus.BAD_REQUEST); }
    }
}
