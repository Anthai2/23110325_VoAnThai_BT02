package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.File;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;

import model.Category;
import service.CategoryService;
import service.CategoryServiceImpl;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/admin/category/edit")
@MultipartConfig(
    fileSizeThreshold = 2 * 1024 * 1024,
    maxFileSize       = 10 * 1024 * 1024,
    maxRequestSize    = 20 * 1024 * 1024
)
public class CategoryEditController extends HttpServlet {
    private final CategoryService service = new CategoryServiceImpl();

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        req.setAttribute("category", service.findById(id));
        req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
    }

    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        int id = Integer.parseInt(readField(req, "id"));
        String name = readField(req, "name");
        String oldIcon = readField(req, "oldIcon");

        String iconPath = oldIcon;
        Part iconPart = req.getPart("iconFile");
        if (iconPart != null && iconPart.getSize() > 0) {
            if (!iconPart.getContentType().startsWith("image/")) {
                req.setAttribute("alert", "File icon phải là ảnh.");
                req.setAttribute("category", service.findById(id));
                req.getRequestDispatcher("/views/admin/category-edit.jsp").forward(req, resp);
                return;
            }
            String uploadDir = getServletContext().getRealPath("/uploads/category");
            Files.createDirectories(Paths.get(uploadDir));

            String submitted = Paths.get(iconPart.getSubmittedFileName()).getFileName().toString();
            String ext = ""; int dot = submitted.lastIndexOf('.'); if (dot >= 0) ext = submitted.substring(dot);
            String saved = "cate_" + System.currentTimeMillis() + "_" + Math.abs(submitted.hashCode()) + ext;

            iconPart.write(uploadDir + File.separator + saved);
            iconPath = "uploads/category/" + saved;

            // xóa file cũ nếu thuộc uploads/
            if (oldIcon != null && oldIcon.startsWith("uploads/")) {
                try { Files.deleteIfExists(Paths.get(getServletContext().getRealPath("/"), oldIcon)); } catch (Exception ignore) {}
            }
        }

        service.update(new Category(id, name.trim(), iconPath));
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }

    private String readField(HttpServletRequest req, String field)
            throws IOException, ServletException {
        String v = req.getParameter(field);
        if (v != null) return v.trim();
        Part p = req.getPart(field);
        if (p != null) {
            try (var in = p.getInputStream()) {
                return new String(in.readAllBytes(), StandardCharsets.UTF_8).trim();
            }
        }
        return "";
    }
}
