package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

import service.UserService;
import service.UserServiceImpl;

@WebServlet("/forgot")
public class ForgotPasswordController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/forgot.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String email = safe(req.getParameter("email"));
        String phone = safe(req.getParameter("phone"));
        String p1    = safe(req.getParameter("pass1"));
        String p2    = safe(req.getParameter("pass2"));

        if (email.isEmpty() || phone.isEmpty() || p1.isEmpty() || p2.isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ thông tin.");
            req.getRequestDispatcher("/views/forgot.jsp").forward(req, resp);
            return;
        }
        if (!p1.equals(p2)) {
            req.setAttribute("alert", "Mật khẩu xác nhận không khớp.");
            req.getRequestDispatcher("/views/forgot.jsp").forward(req, resp);
            return;
        }
        if (p1.length() < 4) {
            req.setAttribute("alert", "Mật khẩu mới phải có ít nhất 4 ký tự.");
            req.getRequestDispatcher("/views/forgot.jsp").forward(req, resp);
            return;
        }

        boolean ok = userService.resetPasswordByEmailPhone(email, phone, p1);
        if (ok) {
            // chuyển về /login với thông báo thành công
            resp.sendRedirect(req.getContextPath() + "/login?msg=reset_ok");
        } else {
            req.setAttribute("alert", "Email hoặc SĐT không đúng (hoặc không trùng khớp).");
            req.getRequestDispatcher("/views/forgot.jsp").forward(req, resp);
        }
    }

    private String safe(String s){ return s == null ? "" : s.trim(); }
}
