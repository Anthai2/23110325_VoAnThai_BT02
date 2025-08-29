<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<jsp:include page="/views/topbar.jsp" />

<style>
:root {
	--bg: #faf6f1;
	--card: #fffaf4;
	--accent: #8b5e3c;
	--accent-2: #a67c52;
	--text: #3d2b1f;
	--muted: #7a6552;
	--border: #eadfd4;
}

body {
	background: var(--bg);
}

.wrap {
	max-width: 460px;
	margin: 22px auto;
	font-family: system-ui, Arial;
	color: var(--text);
}

.card {
	background: var(--card);
	border: 1px solid var(--border);
	border-radius: 16px;
	padding: 22px 20px;
	box-shadow: 0 6px 18px rgba(139, 94, 60, .08);
}

h2 {
	margin: 0 0 14px;
	font-weight: 700;
	letter-spacing: .2px;
}

.hint {
	color: var(--muted);
	margin-bottom: 10px;
}

label {
	display: block;
	margin: 12px 0 6px;
}

input[type=text], input[type=password] {
	width: 100%;
	padding: 10px 12px;
	border: 1px solid var(--border);
	border-radius: 12px;
	background: #fff;
	box-sizing: border-box;
	color: var(--text);
	outline: none;
	transition: .2s border, .2s box-shadow;
}

input:focus {
	border-color: var(--accent-2);
	box-shadow: 0 0 0 3px rgba(166, 124, 82, .18);
}

.row {
	display: flex;
	align-items: center;
	gap: 8px;
	margin: 10px 0 2px;
}

.btn {
	display: table;
	margin: 12px auto 0;
	padding: 10px 16px;
	border: 0;
	border-radius: 12px;
	background: var(--accent);
	color: #fff;
	cursor: pointer;
	font-weight: 600;
	box-shadow: 0 6px 14px rgba(139, 94, 60, .18);
	transition: transform .05s ease;
}

.btn:active {
	transform: translateY(1px);
}

a {
	color: var(--accent);
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.alert {
	color: #b23b3b;
	background: #fff5f5;
	border: 1px solid #f0d4d4;
	padding: 8px 10px;
	border-radius: 10px;
	margin-bottom: 12px;
}

.success {
	color: #2e7d32;
	background: #f0fff2;
	border: 1px solid #c7e8cc;
	padding: 8px 10px;
	border-radius: 10px;
	margin-bottom: 12px;
}

.subtle {
	text-align: center;
	margin-top: 10px;
}
</style>

<div class="wrap">
	<div class="card">
		<h2>Đăng nhập</h2>
		<p class="hint">Chào mừng trở lại 👋</p>

		<!-- Thông báo sau khi đặt lại mật khẩu -->
		<c:if test="${param.msg == 'reset_ok'}">
			<div class="success">Mật khẩu đã được cập nhật. Vui lòng đăng
				nhập.</div>
		</c:if>

		<c:if test="${not empty alert}">
			<div class="alert">
				<c:out value="${alert}" />
			</div>
		</c:if>

		<!-- Prefill username từ param hoặc cookie "username" -->
		<c:set var="cookieUser"
			value="${cookie['username'] != null ? cookie['username'].value : ''}" />
		<c:set var="usernamePrefill"
			value="${empty param.username ? cookieUser : param.username}" />
		<c:set var="rememberChecked"
			value="${not empty param.remember or not empty cookieUser}" />

		<form action="${pageContext.request.contextPath}/login" method="post"
			accept-charset="UTF-8" autocomplete="on">
			<label for="username">Tài khoản</label> <input id="username"
				type="text" name="username" value="${fn:escapeXml(usernamePrefill)}"
				required autocomplete="username" autofocus /> <label for="password">Mật
				khẩu</label> <input id="password" type="password" name="password" required
				autocomplete="current-password" />

			<div class="row">
				<input type="checkbox" id="remember" name="remember"
					<c:if test="${rememberChecked}">checked</c:if> /> <label
					for="remember" style="margin: 0;">Nhớ tôi</label>
			</div>

			<button class="btn" type="submit">Đăng nhập</button>

			<div class="subtle">
				<a href="${pageContext.request.contextPath}/forgot">Quên mật
					khẩu?</a>
			</div>

			<div class="subtle">
				Chưa có tài khoản? <a
					href="${pageContext.request.contextPath}/register">Đăng ký</a>
			</div>
		</form>
	</div>
</div>
