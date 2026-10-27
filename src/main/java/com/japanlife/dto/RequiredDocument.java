package com.japanlife.dto;

public class RequiredDocument {
    private Long id;
    private String name;
    private String requirement;
    private String conditionText;
    private String description;
    private String preparationNote;
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRequirement() { return requirement; }
    public void setRequirement(String requirement) { this.requirement = requirement; }
    public String getConditionText() { return conditionText; }
    public void setConditionText(String conditionText) { this.conditionText = conditionText; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getPreparationNote() { return preparationNote; }
    public void setPreparationNote(String preparationNote) { this.preparationNote = preparationNote; }
}
