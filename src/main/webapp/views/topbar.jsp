<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
  :root{ --bg:#faf6f1; --card:#fffaf4; --accent:#8b5e3c; --border:#eadfd4; --text:#3d2b1f; --muted:#7a6552; }
  .tb{ font-family:system-ui, Arial; background:var(--card); border-bottom:1px solid var(--border); position:sticky; top:0; z-index:10; }
  .tb .inner{ max-width:1000px; margin:0 auto; display:grid; grid-template-columns:1fr auto 1fr; align-items:center; padding:10px 14px; color:var(--text); }
  .brand{ display:flex; align-items:center; gap:8px; font-weight:700; letter-spacing:.2px; }
  .brand a{ color:inherit; text-decoration:none; }
  .center{ justify-self:center; }
  .center-link{ display:inline-flex; align-items:center; justify-content:center; height:40px; padding:0 10px; border-radius:12px; color:var(--accent); text-decoration:none; font-weight:600; }
  .center-link:hover{ background:rgba(139,94,60,.08); }

  .auth{ justify-self:end; display:flex; align-items:center; gap:12px; }
  .pill{ display:inline-flex; align-items:center; justify-content:center; height:40px; padding:0 16px; border-radius:12px; line-height:1; text-decoration:none; border:1px solid transparent; }
  .pill.ghost{ background:#fff; color:var(--accent); border-color:var(--border); }
  .pill.solid{ background:var(--accent); color:#fff; box-shadow:0 6px 14px rgba(139,94,60,.18); }
  .pill:hover{ filter:brightness(0.98); }
</style>

<div class="tb">
  <div class="inner">
    <!-- Trái -->
    <div class="brand">
      <a href="${ctx}/views/home.jsp">WebApp</a>
    </div>

    <!-- Giữa -->
    <div class="center">
      <a class="center-link" href="${ctx}/views/home.jsp">Trang chủ</a>
    </div>

    <!-- Phải -->
    <div class="auth">
      <c:choose>
        <c:when test="${not empty sessionScope.account}">
          <a class="pill ghost" href="${ctx}/views/home.jsp">Tài khoản</a>
          <a class="pill solid" href="${ctx}/logout">Đăng xuất</a>
        </c:when>
        <c:otherwise>
          <a class="pill ghost" href="${ctx}/login">Đăng nhập</a>
          <a class="pill solid" href="${ctx}/register">Đăng ký</a>
        </c:otherwise>
      </c:choose>

      <!-- LƯU Ý: c:if đặt NGOÀI c:choose -->
      <c:if test="${not empty sessionScope.account && sessionScope.account.roleid == 1}">
        <a class="pill" href="${ctx}/admin/category/list">Danh mục</a>
      </c:if>
    </div>
  </div>
</div>
