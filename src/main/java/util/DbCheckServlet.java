package util;


import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dbcheck")
public class DbCheckServlet extends HttpServlet {
  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

  @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
    try (var c = new DBConnection().getConnection()) {
      resp.getWriter().println("DB OK");
    } catch (Exception e) {
      e.printStackTrace();
      resp.getWriter().println("DB FAIL: " + e.getMessage());
    }
  }
}