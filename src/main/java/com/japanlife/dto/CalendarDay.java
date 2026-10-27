package com.japanlife.dto;

public class CalendarDay {
    private String date;
    private int day;
    private boolean inMonth;
    private boolean today;
    private boolean selected;
    private int eventCount;

    public CalendarDay(String date, int day, boolean inMonth, boolean today, boolean selected, int eventCount) {
        this.date = date; this.day = day; this.inMonth = inMonth; this.today = today;
        this.selected = selected; this.eventCount = eventCount;
    }
    public String getDate() { return date; }
    public int getDay() { return day; }
    public boolean isInMonth() { return inMonth; }
    public boolean isToday() { return today; }
    public boolean isSelected() { return selected; }
    public int getEventCount() { return eventCount; }
}
