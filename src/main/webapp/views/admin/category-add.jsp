<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<style>
  :root{ --bg:#faf6f1; --card:#fffaf4; --text:#3d2b1f; --muted:#7a6552; --border:#eadfd4; --accent:#8b5e3c; --sidebar:#7a4a2b; --topbar:#8b5e3c; --danger:#b84a3a;}
  *{box-sizing:border-box} body{margin:0;background:var(--bg);font-family:system-ui,Arial;color:var(--text)}
  .shell{display:grid;grid-template-columns:240px 1fr;min-height:100vh}
  .aside{background:var(--sidebar);color:#fff}
  .brand{padding:16px 20px;font-size:26px;font-weight:800}
  .menu a{display:block;color:#fff;padding:12px 18px}
  .menu a:hover{background:rgba(255,255,255,.08)}
  .menu a.active{background:rgba(0,0,0,.18)}
  .top{background:var(--topbar);color:#fff;display:flex;justify-content:flex-end;padding:10px 16px}
  .btn-white{padding:8px 12px;border-radius:10px;border:1px solid rgba(255,255,255,.6);color:#fff;text-decoration:none}
  .content{padding:22px}
  .card{background:var(--card);border:1px solid var(--border);border-radius:16px;padding:18px;max-width:820px;box-shadow:0 14px 28px rgba(139,94,60,.06)}
  .title{margin:0 0 6px;font-size:26px}
  .subtitle{color:var(--muted);margin:0 0 12px}
  label{display:block;margin:12px 0 6px}
  input[type=text]{width:100%;padding:11px 12px;border:1px solid var(--border);border-radius:12px;background:#fff}
  .btn-main{background:var(--accent);color:#fff;border:0;padding:10px 16px;border-radius:12px;margin-top:14px}
  .alert{color:var(--danger);background:#fff3f3;border:1px solid #f2d6d2;padding:10px 12px;border-radius:12px;margin:0 0 12px}
  /* dropzone */
  .drop{border:2px dashed var(--border);border-radius:14px;background:#fff;padding:14px;display:flex;gap:14px;align-items:center;cursor:pointer}
  .drop:hover{background:#fffdf9}
  .thumb{width:72px;height:72px;border-radius:12px;object-fit:cover;border:1px solid var(--border);background:#f3efe9}
  .hint{color:var(--muted);font-size:13px}
  .hidden{display:none}
</style>

<div class="shell">
  <aside class="aside">
    <div class="brand">Dashboard</div>
    <nav class="menu">
      <a href="${ctx}/admin/category/list">Quản lý Danh mục</a>
      <a class="active" href="${ctx}/admin/category/add">Thêm danh mục</a>
    </nav>
  </aside>

  <div>
    <div class="top"><a class="btn-white" href="${ctx}/logout">Đăng xuất</a></div>
    <main class="content">
      <div class="card">
        <h2 class="title">Thêm danh mục</h2>
        <p class="subtitle">Tải ảnh icon (tuỳ chọn) và nhập tên danh mục của bạn.</p>

        <c:if test="${not empty alert}">
          <div class="alert">${alert}</div>
        </c:if>

        <form method="post" action="${ctx}/admin/category/add" enctype="multipart/form-data" id="frm">
          <label for="name">Tên danh mục</label>
          <input id="name" name="name" placeholder="VD: Máy ảnh" required />

          <label>Icon</label>
          <div id="drop" class="drop">
            <img id="preview" class="thumb hidden" alt="preview"/>
            <div>
              <div style="font-weight:600">Kéo-thả ảnh vào đây hoặc bấm để chọn</div>
              <div class="hint">PNG/JPG, &le; 2MB. Hình vuông trông sẽ đẹp hơn.</div>
            </div>
            <input id="iconFile" name="iconFile" type="file" accept="image/*" class="hidden"/>
          </div>

          <button class="btn-main" type="submit">Lưu</button>
        </form>
      </div>
    </main>
  </div>
</div>

<script>
  // dropzone & preview
  const dz = document.getElementById('drop');
  const file = document.getElementById('iconFile');
  const preview = document.getElementById('preview');

  dz.addEventListener('click', () => file.click());
  dz.addEventListener('dragover', e => {e.preventDefault(); dz.style.background='#fff8f0';});
  dz.addEventListener('dragleave', () => dz.style.background='');
  dz.addEventListener('drop', e => {e.preventDefault(); dz.style.background=''; if (e.dataTransfer.files.length) { file.files = e.dataTransfer.files; show(); }});
  file.addEventListener('change', show);

  function show(){
    const f = file.files[0];
    if(!f) return;
    if(!f.type.startsWith('image/')) return alert('Chỉ chọn file ảnh!');
    if(f.size > 2*1024*1024) return alert('Ảnh
