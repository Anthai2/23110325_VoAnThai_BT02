package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import service.CategoryService;
import service.CategoryServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/admin/category/list")
public class CategoryListController extends HttpServlet {
    private final CategoryService service = new CategoryServiceImpl();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("categories", service.findAll());
        req.getRequestDispatcher("/views/admin/category-list.jsp").forward(req, resp);
    }
}
