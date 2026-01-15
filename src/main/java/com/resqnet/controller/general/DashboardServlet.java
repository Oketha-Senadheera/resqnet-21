package com.resqnet.controller.general;

import com.resqnet.model.Role;
import com.resqnet.model.User;
import com.resqnet.model.dao.GeneralUserDAO;
import com.resqnet.dao.SafeLocationDAO;
import com.resqnet.dao.SafeLocationDAOImpl;
import java.util.List;
import com.resqnet.model.SafeLocation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/general/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        // Check if user is logged in
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("authUser");

        // Check if user has GENERAL role
        if (user.getRole() != Role.GENERAL) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }

        // Load display name
        try {
            new GeneralUserDAO().findByUserId(user.getId())
                    .ifPresent(gu -> req.setAttribute("displayName", gu.getName()));
        } catch (Exception ignored) {
        }

        // Load Safe Locations
        try {
            List<SafeLocation> locations = new SafeLocationDAOImpl().findAll();
            req.setAttribute("locationList", locations);
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.getRequestDispatcher("/WEB-INF/views/general-user/dashboard.jsp").forward(req, resp);
    }
}
