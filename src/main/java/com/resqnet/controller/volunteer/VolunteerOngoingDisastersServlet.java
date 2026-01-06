package com.resqnet.controller.volunteer;

import com.resqnet.model.DisasterReport;
import com.resqnet.model.Role;
import com.resqnet.model.User;
import com.resqnet.model.VolunteerAssignment;
import com.resqnet.model.dao.DisasterReportDAO;
import com.resqnet.model.dao.VolunteerAssignmentDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/volunteer/ongoing-disasters")
public class VolunteerOngoingDisastersServlet extends HttpServlet {

    private final DisasterReportDAO disasterReportDAO = new DisasterReportDAO();
    private final VolunteerAssignmentDAO volunteerAssignmentDAO = new VolunteerAssignmentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("authUser");
        if (user.getRole() != Role.VOLUNTEER) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Fetch verified (Approved) disaster reports
        List<DisasterReport> approvedReports = disasterReportDAO.findByStatus("Approved");

        // Fetch user's assignments
        List<VolunteerAssignment> myAssignments = volunteerAssignmentDAO.findByUserId(user.getId());
        Map<Integer, VolunteerAssignment> assignmentMap = myAssignments.stream()
                .collect(Collectors.toMap(VolunteerAssignment::getReportId, a -> a));

        req.setAttribute("approvedReports", approvedReports);
        req.setAttribute("assignmentMap", assignmentMap);

        req.getRequestDispatcher("/WEB-INF/views/volunteer/ongoing_disasters.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("authUser");
        if (user.getRole() != Role.VOLUNTEER) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = req.getParameter("action");
        String reportIdStr = req.getParameter("reportId");

        if (reportIdStr == null || !reportIdStr.matches("\\d+")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid report ID");
            return;
        }
        int reportId = Integer.parseInt(reportIdStr);

        if ("assist".equals(action)) {
            // Create assignment
            try {
                VolunteerAssignment assignment = new VolunteerAssignment(user.getId(), reportId, "Assigned");
                assignment.setNotes("");
                volunteerAssignmentDAO.create(assignment);
                req.getSession().setAttribute("flashMessage", "You are now assisting with this disaster.");
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("flashError", "Could not assign: " + e.getMessage());
            }
        } else if ("update_notes".equals(action)) {
            // Update notes
            String notes = req.getParameter("notes");
            String assignmentIdStr = req.getParameter("assignmentId");
            if (assignmentIdStr != null && assignmentIdStr.matches("\\d+")) {
                int assignmentId = Integer.parseInt(assignmentIdStr);
                VolunteerAssignment assignment = new VolunteerAssignment();
                assignment.setAssignmentId(assignmentId);
                assignment.setStatus("Assigned"); // Keep as assigned for now, or allow logic to complete
                assignment.setNotes(notes);
                volunteerAssignmentDAO.update(assignment);
                req.getSession().setAttribute("flashMessage", "Notes updated successfully.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/volunteer/ongoing-disasters");
    }
}
