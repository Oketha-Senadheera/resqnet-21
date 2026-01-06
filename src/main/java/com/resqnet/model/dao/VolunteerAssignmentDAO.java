package com.resqnet.model.dao;

import com.resqnet.model.VolunteerAssignment;
import com.resqnet.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class VolunteerAssignmentDAO {

    public void create(VolunteerAssignment assignment) {
        String sql = "INSERT INTO volunteer_assignments (user_id, report_id, status, notes) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, assignment.getUserId());
            ps.setInt(2, assignment.getReportId());
            ps.setString(3, assignment.getStatus());
            ps.setString(4, assignment.getNotes());
            ps.executeUpdate();

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    assignment.setAssignmentId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error creating volunteer assignment", e);
        }
    }

    public void update(VolunteerAssignment assignment) {
        String sql = "UPDATE volunteer_assignments SET status = ?, notes = ? WHERE assignment_id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, assignment.getStatus());
            ps.setString(2, assignment.getNotes());
            ps.setInt(3, assignment.getAssignmentId());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Error updating volunteer assignment", e);
        }
    }

    public Optional<VolunteerAssignment> findByUserAndReport(int userId, int reportId) {
        String sql = "SELECT * FROM volunteer_assignments WHERE user_id = ? AND report_id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, reportId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding volunteer assignment", e);
        }
        return Optional.empty();
    }

    public List<VolunteerAssignment> findByUserId(int userId) {
        List<VolunteerAssignment> list = new ArrayList<>();
        String sql = "SELECT * FROM volunteer_assignments WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error finding volunteer assignments", e);
        }
        return list;
    }

    private VolunteerAssignment map(ResultSet rs) throws SQLException {
        VolunteerAssignment assignment = new VolunteerAssignment();
        assignment.setAssignmentId(rs.getInt("assignment_id"));
        assignment.setUserId(rs.getInt("user_id"));
        assignment.setReportId(rs.getInt("report_id"));
        assignment.setStatus(rs.getString("status"));
        assignment.setNotes(rs.getString("notes"));
        assignment.setAssignedAt(rs.getTimestamp("assigned_at"));
        return assignment;
    }
}
