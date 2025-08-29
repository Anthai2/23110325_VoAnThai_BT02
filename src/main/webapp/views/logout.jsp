<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
         import="jakarta.servlet.http.Cookie" %>
<%


  // Xóa cookie "username" (Remember me)
  String ctx  = request.getContextPath();
  String path = (ctx == null || ctx.isEmpty()) ? "/" : ctx;

  Cookie kill = new Cookie("username", "");
  kill.setHttpOnly(true);
  kill.setMaxAge(0);
  kill.setPath(path);
  response.addCookie(kill);
  // Xóa header SameSite nếu trước đó đã set
  response.addHeader("Set-Cookie", "username=; Max-Age=0; Path=" + path + "; SameSite=Lax");

  // Quay lại trang login (đi qua servlet /login)
  response.sendRedirect(ctx + "/login");
  return;
%>
