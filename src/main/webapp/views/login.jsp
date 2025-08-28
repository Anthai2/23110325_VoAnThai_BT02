<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:url var="loginUrl" value="/login"/>

<form action="${loginUrl}" method="post" accept-charset="UTF-8" class="login-form">
  <h2>Đăng nhập</h2>

  <c:if test="${not empty alert}">
    <h3 class="alert alert-danger"><c:out value="${alert}"/></h3>
  </c:if>

  <section>
    <label class="input login-input">
      <div class="input-group">
        <span class="input-group-addon"><i class="fa fa-user"></i></span>
        <input
          type="text"
          name="username"
          placeholder="Tài khoản"
          class="form-control"
          value="${fn:escapeXml(param.username)}"
          autofocus
          required />
      </div>
    </label>
  </section>

  <section>
    <label class="input login-input">
      <div class="input-group">
        <span class="input-group-addon"><i class="fa fa-lock"></i></span>
        <input
          type="password"
          name="password"
          placeholder="Mật khẩu"
          class="form-control"
          required />
      </div>
    </label>
  </section>

  <section style="margin:8px 0;">
    <label><input type="checkbox" name="remember" /> Ghi nhớ đăng nhập</label>
  </section>

  <button type="submit" class="btn btn-primary">Đăng nhập</button>
</form>
