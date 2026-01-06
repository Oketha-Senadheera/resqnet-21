package com.resqnet.model;

import java.sql.Timestamp;

public class VolunteerAssignment {
    private Integer assignmentId;
    private Integer userId;
    private Integer reportId;
    private String status;
    private String notes;
    private Timestamp assignedAt;

    public VolunteerAssignment() {
    }

    public VolunteerAssignment(Integer userId, Integer reportId, String status) {
        this.userId = userId;
        this.reportId = reportId;
        this.status = status;
    }

    public Integer getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(Integer assignmentId) {
        this.assignmentId = assignmentId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getReportId() {
        return reportId;
    }

    public void setReportId(Integer reportId) {
        this.reportId = reportId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public Timestamp getAssignedAt() {
        return assignedAt;
    }

    public void setAssignedAt(Timestamp assignedAt) {
        this.assignedAt = assignedAt;
    }
}
