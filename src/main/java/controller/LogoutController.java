package controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session != null) session.invalidate();

        String ctx  = req.getContextPath();
        String path = (ctx == null || ctx.isEmpty()) ? "/" : ctx;

        Cookie kill = new Cookie("username", "");
        kill.setHttpOnly(true);
        kill.setMaxAge(0);
        kill.setPath(path);
        resp.addCookie(kill);
        resp.addHeader("Set-Cookie", "username=; Max-Age=0; Path=" + path + "; SameSite=Lax");

        resp.sendRedirect(ctx + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        doGet(req, resp);
    }
}
