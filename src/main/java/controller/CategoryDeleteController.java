package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.nio.file.*;

import service.CategoryService;
import service.CategoryServiceImpl;
import model.Category;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/admin/category/delete")
public class CategoryDeleteController extends HttpServlet {
    private final CategoryService service = new CategoryServiceImpl();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        Category c = service.findById(id);
        if (c != null && c.getIcon() != null && c.getIcon().startsWith("uploads/")) {
            try {
                Files.deleteIfExists(Paths.get(getServletContext().getRealPath("/"), c.getIcon()));
            } catch (Exception ignore) {}
        }

        service.delete(id);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
