package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import service.UserService;
import service.UserServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");

        String username = safe(req.getParameter("username"));
        String password = safe(req.getParameter("password"));
        String email    = safe(req.getParameter("email"));
        String fullname = safe(req.getParameter("fullname"));
        String phone    = safe(req.getParameter("phone"));

        if (username.isEmpty() || password.isEmpty() || email.isEmpty() || fullname.isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ thông tin.");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        UserService service = new UserServiceImpl();

        if (service.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (service.checkExistUsername(username)) {
            req.setAttribute("alert", "Tài khoản đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }
        if (!phone.isEmpty() && service.checkExistPhone(phone)) {
            req.setAttribute("alert", "Số điện thoại đã tồn tại!");
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
            return;
        }

        boolean ok = service.register(username, password, email, fullname, phone);
        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("alert", "Đăng ký thất bại (trùng dữ liệu hoặc lỗi DB)");
            // SỬA: forward về /views, KHÔNG phải /WEB-INF
            req.getRequestDispatcher("/views/register.jsp").forward(req, resp);
        }
    }

    private String safe(String s){ return s == null ? "" : s.trim(); }
}
