<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt"%>
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
	max-width: 900px;
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

.muted {
	color: var(--muted);
}

.grid {
	display: grid;
	grid-template-columns: 180px 1fr;
	gap: 10px 18px;
}

.avatar {
	width: 96px;
	height: 96px;
	border-radius: 50%;
	object-fit: cover;
	border: 1px solid var(--border);
}

a {
	color: var(--accent);
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

/* Buttons */
.btn {
	display: inline-block;
	padding: 10px 18px;
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

.btn-ghost {
	background: #fff;
	border: 1px solid var(--border);
	color: var(--accent);
	box-shadow: none;
}
/* Row with "hoặc" */
.actions {
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 12px;
	margin-top: 14px;
}

.or {
	font-size: .9rem;
	color: var(--muted);
}
</style>

<div class="wrap">
	<c:choose>
		<c:when test="${not empty sessionScope.account}">
			<div class="card">
				<h2 style="margin-top: 0;">Xin chào,
					${sessionScope.account.fullName} 👋</h2>
				<p class="muted" style="margin-top: 6px;">Chúc bạn một ngày tốt
					lành.</p>

				<div
					style="display: flex; gap: 18px; align-items: flex-start; margin-top: 16px;">
					<c:if test="${not empty sessionScope.account.avatar}">
						<img class="avatar" src="${sessionScope.account.avatar}"
							alt="avatar" />
					</c:if>

					<div class="grid">
						<div class="muted">Tài khoản</div>
						<div>${sessionScope.account.userName}</div>

						<div class="muted">Email</div>
						<div>${sessionScope.account.email}</div>

						<div class="muted">Vai trò</div>
						<div>
							<c:choose>
								<c:when test="${sessionScope.account.roleid == 1}">Admin</c:when>
								<c:when test="${sessionScope.account.roleid == 2}">Manager</c:when>
								<c:otherwise>Người dùng</c:otherwise>
							</c:choose>
							<span class="muted">(ID: ${sessionScope.account.roleid})</span>
						</div>

						<div class="muted">Số điện thoại</div>
						<div>${sessionScope.account.phone}</div>

						<div class="muted">Ngày tạo</div>
						<div>
							<c:if test="${not empty sessionScope.account.createdDate}">
								<fmt:formatDate value="${sessionScope.account.createdDate}"
									pattern="dd/MM/yyyy HH:mm" />
							</c:if>
						</div>
					</div>
				</div>

				<div class="actions" style="margin-top: 16px;">
					<a class="btn" href="${pageContext.request.contextPath}/logout">Đăng
						xuất</a>
				</div>
			</div>
		</c:when>

		<c:otherwise>
			<div class="card">
				<h2 style="margin-top: 0;">Chào mừng bạn!</h2>
				<p class="muted">Bạn chưa đăng nhập. Hãy bắt đầu bằng cách:</p>

				<!-- Hai nút cùng hàng + chữ “hoặc” nhỏ ở giữa -->
				<div class="actions">
					<a class="btn" href="${pageContext.request.contextPath}/login">Đăng
						nhập</a> <span class="or">hoặc</span> <a class="btn btn-ghost"
						href="${pageContext.request.contextPath}/register">Đăng ký</a>
				</div>
			</div>
		</c:otherwise>
	</c:choose>
</div>
