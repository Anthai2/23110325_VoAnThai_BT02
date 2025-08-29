package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import model.User;

@WebServlet("/waiting")
public class WaitingController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        String ctx = req.getContextPath();

        if (session != null && session.getAttribute("account") != null) {
            // Cấu trúc của bạn chỉ có /views/home.jsp
            resp.sendRedirect(ctx + "/views/home.jsp");
            return;

            // Nếu sau này bạn tạo trang riêng theo role, dùng đoạn sau:
            // User u = (User) session.getAttribute("account");
            // if (u.getRoleid() == 1) {
            //     resp.sendRedirect(ctx + "/views/admin/home.jsp");
            // } else if (u.getRoleid() == 2) {
            //     resp.sendRedirect(ctx + "/views/manager/home.jsp");
            // } else {
            //     resp.sendRedirect(ctx + "/views/home.jsp");
            // }
        }

        // Chưa đăng nhập -> về trang /login (qua LoginController)
        resp.sendRedirect(ctx + "/login");
    }
}
