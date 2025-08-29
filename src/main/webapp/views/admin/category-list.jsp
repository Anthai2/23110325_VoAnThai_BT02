<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
  :root{
    --bg:#faf6f1; --card:#fffaf4; --text:#3d2b1f; --muted:#7a6552; --border:#eadfd4;
    --accent:#8b5e3c; --accent-2:#a67c52; --danger:#b84a3a; --sidebar:#7a4a2b; --topbar:#8b5e3c;
  }
  *{box-sizing:border-box} body{margin:0;background:var(--bg);font-family:system-ui,Arial;color:var(--text)}
  a{text-decoration:none;color:var(--accent)}
  /* layout */
  .shell{display:grid;grid-template-columns:240px 1fr;min-height:100vh}
  .aside{background:var(--sidebar);color:#fff}
  .brand{padding:16px 20px;font-size:26px;font-weight:800}
  .menu a{display:block;color:#fff;padding:12px 18px;border-left:3px solid transparent}
  .menu a:hover{background:rgba(255,255,255,.08)}
  .menu a.active{background:rgba(0,0,0,.18);border-left-color:#f3e6d8}
  .top{background:var(--topbar);color:#fff;display:flex;align-items:center;gap:10px;padding:10px 16px}
  .hello{margin-right:auto;font-weight:600}
  .btn-white{padding:8px 12px;border-radius:10px;border:1px solid rgba(255,255,255,.6);color:#fff}
  .content{padding:22px}
  /* card & toolbar */
  .card{background:var(--card);border:1px solid var(--border);border-radius:16px;padding:18px;box-shadow:0 14px 28px rgba(139,94,60,.06)}
  .bread{color:var(--muted);font-size:13px;margin:0 0 10px}
  .title{margin:0;font-size:26px}
  .subtitle{margin:4px 0 14px;color:var(--muted)}
  .tools{display:flex;flex-wrap:wrap;gap:10px;align-items:center;margin-bottom:12px}
  .btn-main{background:var(--accent);color:#fff;border:0;padding:9px 14px;border-radius:12px;box-shadow:0 8px 18px rgba(139,94,60,.16)}
  .btn-main:hover{filter:brightness(.97)}
  .select,.search{padding:10px 12px;border:1px solid var(--border);border-radius:12px;background:#fff}
  .search{min-width:220px}
  /* table */
  table{width:100%;border-collapse:collapse}
  thead th{position:sticky;top:0;background:linear-gradient(#fffaf4,#fff7ef);border-bottom:1px solid var(--border)}
  th,td{padding:12px;border-bottom:1px solid var(--border)}
  tbody tr:nth-child(even){background:#fff7ef}
  tbody tr:hover{background:#fff2e6}
  .thumb{width:60px;height:60px;border-radius:12px;object-fit:cover;border:1px solid var(--border);background:#f3efe9}
  .actions a{margin:0 6px}
  .actions a.del{color:var(--danger)}
  .empty{padding:26px;border:1px dashed var(--border);border-radius:14px;background:#fff;display:flex;align-items:center;gap:12px;color:var(--muted)}
  /* responsive */
  @media (max-width: 900px){
    .shell{grid-template-columns:1fr}
    .aside{display:none}
    .search{flex:1}
  }
</style>

<div class="shell">
  <aside class="aside">
    <div class="brand">Dashboard</div>
    <nav class="menu">
      <a href="${ctx}/views/home.jsp">🏠 Trang chủ</a>
      <a class="active" href="${ctx}/admin/category/list">📦 Quản lý Danh mục</a>
      <a href="${ctx}/admin/category/add">➕ Thêm danh mục</a>
    </nav>
  </aside>

  <div>
    <div class="top">
      <div class="hello">Xin chào <b><c:out value='${empty sessionScope.account.fullName ? "Quản trị viên" : sessionScope.account.fullName}'/></b></div>
      <a class="btn-white" href="${ctx}/logout">Đăng xuất</a>
    </div>

    <main class="content">
      <div class="card">
        <div class="bread">Quản trị &rsaquo; Danh mục</div>
        <h2 class="title">Quản lý danh mục</h2>
        <p class="subtitle">Tạo, chỉnh sửa và sắp xếp các nhóm sản phẩm của bạn.</p>

        <div class="tools">
          <a class="btn-main" href="${ctx}/admin/category/add">+ Thêm danh mục</a>
          <select class="select">
            <option>10</option><option>25</option><option>50</option>
          </select>
          <span class="subtitle" style="margin:0">records per page</span>
          <div style="flex:1"></div>
          <input id="q" class="search" type="text" placeholder="Tìm tên danh mục..."/>
        </div>

        <c:choose>
          <c:when test="${empty categories}">
            <div class="empty">📭 Chưa có danh mục nào. Hãy bắt đầu bằng nút <b>+ Thêm danh mục</b>.</div>
          </c:when>
          <c:otherwise>
            <table id="tbl">
              <thead>
              <tr>
                <th style="width:64px">STT</th>
                <th style="width:120px">Hình ảnh</th>
                <th>Tên danh mục</th>
                <th style="width:160px">Hành động</th>
              </tr>
              </thead>
              <tbody>
              <c:forEach items="${categories}" var="c" varStatus="s">
                <tr>
                  <td>${s.index + 1}</td>
                  <td>
                    <c:choose>
                      <c:when test="${not empty c.icon}">
                        <img class="thumb" src="${fn:startsWith(c.icon,'http') ? c.icon : ctx.concat('/').concat(c.icon)}" alt="icon"/>
                      </c:when>
                      <c:otherwise><div class="thumb" style="display:flex;align-items:center;justify-content:center;color:#b39a86">—</div></c:otherwise>
                    </c:choose>
                  </td>
                  <td class="name">${c.name}</td>
                  <td class="actions">
                    <a href="${ctx}/admin/category/edit?id=${c.id}">Sửa</a>
                    <span style="color:#b39a86">|</span>
                    <a class="del" href="${ctx}/admin/category/delete?id=${c.id}" onclick="return confirm('Xóa danh mục này?');">Xóa</a>
                  </td>
                </tr>
              </c:forEach>
              </tbody>
            </table>
          </c:otherwise>
        </c:choose>
      </div>
    </main>
  </div>
</div>

<script>
  // lọc nhanh theo tên
  const q = document.getElementById('q');
  const tbl = document.getElementById('tbl');
  if (q && tbl){
    q.addEventListener('input', () => {
      const kw = q.value.toLowerCase();
      for (const tr of tbl.tBodies[0].rows) {
        const name = tr.querySelector('.name')?.textContent.toLowerCase() || '';
        tr.style.display = name.includes(kw) ? '' : 'none';
      }
    });
  }
</script>
