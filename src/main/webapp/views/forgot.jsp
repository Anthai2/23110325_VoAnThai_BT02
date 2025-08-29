<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="/views/topbar.jsp"/>

<style>
  :root{ --bg:#faf6f1; --card:#fffaf4; --accent:#8b5e3c; --accent-2:#a67c52; --text:#3d2b1f; --muted:#7a6552; --border:#eadfd4; }
  body{background:var(--bg);}
  .wrap{max-width:520px;margin:22px auto;font-family:system-ui,Arial;color:var(--text);}
  .card{background:var(--card);border:1px solid var(--border);border-radius:16px;padding:22px 20px;box-shadow:0 6px 18px rgba(139,94,60,.08);}
  h2{margin:0 0 14px;}
  label{display:block;margin:12px 0 6px;}
  input{width:100%;padding:10px 12px;border:1px solid var(--border);border-radius:12px;box-sizing:border-box;}
  input:focus{border-color:var(--accent-2);box-shadow:0 0 0 3px rgba(166,124,82,.18);outline:none;}
  .btn{display:table;margin:12px auto 0;padding:10px 16px;border:0;border-radius:12px;background:var(--accent);color:#fff;font-weight:600;
       box-shadow:0 6px 14px rgba(139,94,60,.18);}
  a{color:var(--accent);text-decoration:none;}
  .alert{color:#b23b3b;background:#fff5f5;border:1px solid #f0d4d4;padding:8px 10px;border-radius:10px;margin-bottom:12px;}
  .success{color:#2e7d32;background:#f0fff2;border:1px solid #c7e8cc;padding:8px 10px;border-radius:10px;margin-bottom:12px;}
  .hint{color:var(--muted);margin-bottom:8px;}
</style>

<div class="wrap">
  <div class="card">
    <h2>Quên mật khẩu</h2>
    <p class="hint">Nhập <b>Email</b> và <b>Số điện thoại</b> đã đăng ký để đặt lại mật khẩu.</p>

    <c:if test="${not empty alert}">
      <div class="alert">${alert}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/forgot" method="post" accept-charset="UTF-8" autocomplete="on">
      <label for="email">Email</label>
      <input id="email" type="email" name="email" value="${param.email}" required autocomplete="email"/>

      <label for="phone">Số điện thoại</label>
      <input id="phone" type="text" name="phone" value="${param.phone}" required/>

      <label for="pass1">Mật khẩu mới</label>
      <input id="pass1" type="password" name="pass1" required autocomplete="new-password"/>

      <label for="pass2">Xác nhận mật khẩu mới</label>
      <input id="pass2" type="password" name="pass2" required autocomplete="new-password"/>

      <button class="btn" type="submit">Cập nhật mật khẩu</button>

      <div style="text-align:center;margin-top:10px;">
        <a href="${pageContext.request.contextPath}/login">Quay lại Đăng nhập</a>
      </div>
    </form>
  </div>
</div>
