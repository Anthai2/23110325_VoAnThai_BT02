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
	max-width: 520px;
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

input[type=text], input[type=password], input[type=email] {
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

.btn {
	display: table;
	margin: 12px auto 0; /* canh giữa ngang */
	padding: 10px 16px;
	border: 0;
	border-radius: 12px;
	background: var(--accent);
	color: #fff;
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
</style>

<div class="wrap">
	<div class="card">
		<h2>Đăng ký</h2>
		<p class="hint">Tạo tài khoản mới để bắt đầu ✨</p>

		<c:if test="${not empty alert}">
			<div class="alert">
				<c:out value="${alert}" />
			</div>
		</c:if>

		<form action="${pageContext.request.contextPath}/register"
			method="post" accept-charset="UTF-8" autocomplete="on">
			<label for="username">Tài khoản</label> <input id="username"
				type="text" name="username" value="${fn:escapeXml(param.username)}"
				required autocomplete="username" /> <label for="password">Mật
				khẩu</label> <input id="password" type="password" name="password" required
				autocomplete="new-password" /> <label for="email">Email</label> <input
				id="email" type="email" name="email"
				value="${fn:escapeXml(param.email)}" required autocomplete="email" />

			<label for="fullname">Họ tên</label> <input id="fullname" type="text"
				name="fullname" value="${fn:escapeXml(param.fullname)}" required />

			<label for="phone">Số điện thoại (tuỳ chọn)</label> <input id="phone"
				type="text" name="phone" value="${fn:escapeXml(param.phone)}" />

			<button class="btn" type="submit">Tạo tài khoản</button>
			<div style="text-align: center; margin-top: 10px">
				Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng
					nhập</a>
			</div>
		</form>
	</div>
</div>
