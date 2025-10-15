package com.resqnet.controller;

import com.resqnet.model.dao.UserDAO;
import com.resqnet.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Optional;
import com.resqnet.util.MailUtil;
import jakarta.mail.MessagingException;

@WebServlet(name = "forgotPasswordRequest", urlPatterns = "/forgot-password")
public class ForgotPasswordRequestServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        if (email == null || email.isBlank()) {
            req.setAttribute("error", "Email is required");
            req.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        Optional<User> userOpt = userDAO.findByEmail(email); // validate existence
        if (userOpt.isEmpty()) {
            req.setAttribute("error", "No account found for that email.");
            req.setAttribute("emailValue", email);
            req.getRequestDispatcher("/WEB-INF/views/auth/forgot-password.jsp").forward(req, resp);
            return;
        }

        String token = userDAO.createResetToken(userOpt.get().getId(), 30); // 30 min
        String resetLink = req.getRequestURL().toString().replace("forgot-password", "reset-password") + "?token=" + token;
        try {
            MailUtil.send(email, "Password Reset", "<p>Click the link to reset your password:</p><p><a href='" + resetLink + "'>" + resetLink + "</a></p><p>If you did not request this, ignore this email.</p>");
            req.setAttribute("emailSent", true);
        } catch (MessagingException e) {
            req.setAttribute("emailSent", false);
            req.setAttribute("mailError", e.getMessage());
        }
        req.getRequestDispatcher("/WEB-INF/views/auth/forgot-password-requested.jsp").forward(req, resp);
    }
}
