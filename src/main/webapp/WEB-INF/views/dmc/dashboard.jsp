<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>ResQnet - DMC Overview</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/core.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dashboard.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://unpkg.com/lucide@latest" defer></script>
    <style>
      .page-title { margin: 0.25rem 0 1.5rem; font-size: 1.65rem; }
      .stats-grid { display:grid; grid-template-columns:repeat(4, minmax(160px, 1fr)); gap:1.25rem; margin: 0 0 2.25rem; }
      .stat-card { background:#fff; border:1px solid var(--color-border); border-radius:var(--radius-lg); padding:1.15rem 1.1rem; display:flex; flex-direction:column; gap:0.4rem; }
      .stat-card .label { font-size:0.8rem; color:#555; font-weight:600; }
      .stat-card .value { font-size:1.85rem; font-weight:700; }
      .safe-card { background:#fff; border:1px solid var(--color-border); border-radius:var(--radius-lg); padding:1.25rem; }
      .safe-card h2 { margin:0 0 1rem; font-size:1.1rem; }
      .safe-grid { display:grid; grid-template-columns:1fr 1.2fr; gap:1.25rem; }
      .add-btn { all:unset; display:block; width:max-content; background:var(--color-accent); font-weight:700; padding:0.65rem 1.2rem; border-radius:999px; cursor:pointer; font-size:0.85rem; margin-bottom:0.8rem; }
      .add-btn:hover { background: var(--color-accent-hover); }
      .loc-list { display:flex; flex-direction:column; gap:0.6rem; }
      .loc-item { background: var(--color-surface); border:1px solid var(--color-border); border-radius: var(--radius-md); padding:0.85rem 0.95rem; }
      .loc-name { font-size:0.9rem; font-weight:600; margin-bottom:0.25rem; }
      .loc-geo { font-size:0.72rem; color:#666; }
      .map-wrap { background: var(--color-surface); border:1px solid var(--color-border); border-radius: var(--radius-md); min-height: 360px; overflow:hidden; }
      .map-wrap iframe { width:100%; height:100%; border:0; display:block; }
      .section-card { background:#fff; border:1px solid var(--color-border); border-radius:var(--radius-lg); padding:1.25rem; }
      .section-card h2 { margin:0 0 1rem; font-size:1.1rem; }
      .table { width:100%; border-collapse:collapse; font-size:0.8rem; }
      .table thead th { text-align:left; padding:0.8rem 1rem; border-bottom:1px solid var(--color-border); background:var(--color-surface); font-size:0.75rem; color:#555; }
      .table tbody td { padding:1rem; border-bottom:1px solid var(--color-border); }
      .table tbody tr:last-child td { border-bottom:none; }
      .table a { color:#4a90e2; text-decoration:none; }
      .table a:hover { text-decoration:underline; }
      .action-pills { display:flex; gap:0.5rem; }
      .pill { all:unset; cursor:pointer; font-weight:700; font-size:0.7rem; padding:0.5rem 0.95rem; border-radius:999px; background:#ededed; color:#222; display:inline-flex; align-items:center; gap:0.35rem; }
      .pill svg { width:14px; height:14px; }
      .pill-danger { background:#e43c35; color:#fff; }
      .pill-confirm { background:#e9e9e9; }
      .status-pending { color:#a86b00; font-weight:600; }
      .status-verified { color:#147a3c; font-weight:700; }
      @media (max-width: 980px) { .stats-grid { grid-template-columns:repeat(2, 1fr); } .safe-grid { grid-template-columns:1fr; } }
      @media (max-width: 560px) { .stats-grid { grid-template-columns:1fr; } }
    </style>
  </head>
  <body>
    <div class="layout">
      <aside class="sidebar" aria-label="Primary">
        <div class="brand">
          <img class="logo-img" src="${pageContext.request.contextPath}/static/assets/img/logo.svg" alt="ResQnet Logo" width="120" height="32" />
          <span class="brand-name sr-only">ResQnet</span>
        </div>
        <nav class="nav">
          <button class="nav-item active" data-section="overview"><span class="icon" data-lucide="home"></span><span>Overview</span></button>
          <button class="nav-item" data-section="forecast"><span class="icon" data-lucide="line-chart"></span><span>Forecast Dashboard</span></button>
          <button class="nav-item" data-section="disaster-reports"><span class="icon" data-lucide="file-text"></span><span>Disaster Reports</span></button>
          <button class="nav-item" data-section="volunteer-apps"><span class="icon" data-lucide="users"></span><span>Volunteer Applications</span></button>
          <button class="nav-item" data-section="delivery-confirmations"><span class="icon" data-lucide="check-square"></span><span>Delivery Confirmations</span></button>
          <button class="nav-item" data-section="safe-locations"><span class="icon" data-lucide="map-pin"></span><span>Safe Locations</span></button>
          <button class="nav-item" data-section="gn-registry"><span class="icon" data-lucide="list"></span><span>GN Registry</span></button>
          <button class="nav-item" data-section="forum"><span class="icon" data-lucide="message-circle"></span><span>Forum</span></button>
          <button class="nav-item" data-section="profile-settings"><span class="icon" data-lucide="user"></span><span>Profile Settings</span></button>
        </nav>
        <div class="sidebar-footer">
          <form method="post" action="${pageContext.request.contextPath}/logout" style="margin:0;">
            <button type="submit" class="logout" aria-label="Logout">↩ Logout</button>
          </form>
        </div>
      </aside>

      <header class="topbar">
        <div class="breadcrumb">DMC Dashboard / <span>Overview</span></div>
        <div class="topbar-right">
          <div class="hotline" role="button" tabindex="0" aria-label="Hotline 117"><span class="hotline-icon" data-lucide="phone"></span>Hotline: <strong>117</strong></div>
          <div class="user-avatar" aria-label="User Menu" role="button"><img src="https://via.placeholder.com/40x40.png?text=U" alt="User Avatar" /></div>
          <button class="menu-toggle" aria-label="Open Menu"><span data-lucide="menu"></span></button>
        </div>
      </header>

      <main class="content" id="mainContent" tabindex="-1">
        <h1 class="page-title">Welcome ${sessionScope.authUser.email}!</h1>

        <section class="stats-grid" aria-label="Key Metrics">
          <article class="stat-card" aria-label="Disaster Reports"><div class="label">Disaster Reports</div><div class="value">12</div></article>
          <article class="stat-card" aria-label="Volunteer Applications"><div class="label">Volunteer Applications</div><div class="value">45</div></article>
          <article class="stat-card" aria-label="Deliveries to Confirm"><div class="label">Deliveries to Confirm</div><div class="value">8</div></article>
          <article class="stat-card" aria-label="GNs Registered"><div class="label">GNs Registered</div><div class="value">230</div></article>
        </section>

        <section class="safe-card" aria-label="Safe Locations">
          <h2>Safe Locations</h2>
          <div class="safe-grid">
            <div>
              <button class="add-btn" id="addLocationBtn">Add New Location</button>
              <div class="loc-list">
                <div class="loc-item"><div class="loc-name">Central Park</div><div class="loc-geo">40.7128° N, 74.0060° W</div></div>
                <div class="loc-item"><div class="loc-name">Griffith Observatory</div><div class="loc-geo">34.0522° N, 118.2437° W</div></div>
                <div class="loc-item"><div class="loc-name">Eiffel Tower</div><div class="loc-geo">48.8566° N, 2.3522° E</div></div>
                <div class="loc-item"><div class="loc-name">Golden Gate Park</div><div class="loc-geo">37.7749° N, 122.4194° W</div></div>
              </div>
            </div>
            <div class="map-wrap">
              <iframe src="https://www.openstreetmap.org/export/embed.html?bbox=-74.0170%2C40.7000%2C-73.9950%2C40.7250&layer=mapnik&marker=40.7128%2C-74.0060" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
          </div>
        </section>

        <section class="section-card" aria-label="Real-time Disaster Reports" style="margin-top:2rem;">
          <h2>Real-time Disaster Reports</h2>
          <div class="table-shell">
            <table class="table">
              <thead><tr><th>Report ID</th><th>Location</th><th>Type</th><th>Status</th><th style="text-align:right;">Actions</th></tr></thead>
              <tbody id="reportsBody">
                <tr>
                  <td>#DR2024-001</td>
                  <td><a href="#">Colombo</a></td>
                  <td>High</td>
                  <td class="status"><span class="status-pending">Pending</span></td>
                  <td style="text-align:right;">
                    <div class="action-pills">
                      <button class="pill pill-verify" data-action="verify"><span data-lucide="check"></span>Verify</button>
                      <button class="pill pill-danger" data-action="reject"><span data-lucide="x"></span>Reject</button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>#DR2024-002</td>
                  <td><a href="#">Colombo</a></td>
                  <td>High</td>
                  <td class="status"><span class="status-pending">Pending</span></td>
                  <td style="text-align:right;">
                    <div class="action-pills">
                      <button class="pill pill-verify" data-action="verify"><span data-lucide="check"></span>Verify</button>
                      <button class="pill pill-danger" data-action="reject"><span data-lucide="x"></span>Reject</button>
                    </div>
                  </td>
                </tr>
                <tr>
                  <td>#DR2024-003</td>
                  <td><a href="#">Colombo</a></td>
                  <td>High</td>
                  <td class="status"><span class="status-pending">Pending</span></td>
                  <td style="text-align:right;">
                    <div class="action-pills">
                      <button class="pill pill-verify" data-action="verify"><span data-lucide="check"></span>Verify</button>
                      <button class="pill pill-danger" data-action="reject"><span data-lucide="x"></span>Reject</button>
                    </div>
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>

        <section class="section-card" aria-label="Incoming NGO Deliveries" style="margin-top:2rem;">
          <h2>Incoming NGO Deliveries</h2>
          <div class="table-shell">
            <table class="table">
              <thead><tr><th>Delivery ID</th><th>NGO</th><th>Items</th><th>Status</th><th style="text-align:right;">Actions</th></tr></thead>
              <tbody id="deliveriesBody">
                <tr>
                  <td>#DLV2024-001</td>
                  <td><a href="#">Relief Aid International</a></td>
                  <td><a href="#">Food, Water</a></td>
                  <td><span class="status-pending">Pending</span></td>
                  <td style="text-align:right;"><button class="pill pill-confirm" data-action="confirm"><span data-lucide="check"></span>Confirm</button></td>
                </tr>
                <tr>
                  <td>#DLV2024-002</td>
                  <td><a href="#">Relief Aid International</a></td>
                  <td><a href="#">Food, Water</a></td>
                  <td><span class="status-pending">Pending</span></td>
                  <td style="text-align:right;"><button class="pill pill-confirm" data-action="confirm"><span data-lucide="check"></span>Confirm</button></td>
                </tr>
                <tr>
                  <td>#DLV2024-003</td>
                  <td><a href="#">Relief Aid International</a></td>
                  <td><a href="#">Food, Water</a></td>
                  <td><span class="status-pending">Pending</span></td>
                  <td style="text-align:right;"><button class="pill pill-confirm" data-action="confirm"><span data-lucide="check"></span>Confirm</button></td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>
      </main>
    </div>

    <script>
      if (window.lucide) lucide.createIcons();

      document.querySelectorAll('.nav-item').forEach((btn) => {
        btn.addEventListener('click', () => {
          document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
          btn.classList.add('active');
        });
      });

      document.getElementById('reportsBody').addEventListener('click', (e) => {
        const btn = e.target.closest('button.pill');
        if (!btn) return;
        const row = btn.closest('tr');
        const statusCell = row.querySelector('.status');
        if (btn.dataset.action === 'verify') {
          statusCell.innerHTML = '<span class="status-verified">Verified</span>';
        } else if (btn.dataset.action === 'reject') {
          row.remove();
        }
        if (window.lucide) lucide.createIcons();
      });

      document.getElementById('deliveriesBody').addEventListener('click', (e) => {
        const btn = e.target.closest('button.pill-confirm');
        if (!btn) return;
        const row = btn.closest('tr');
        row.cells[3].innerHTML = '<span class="status-verified">Confirmed</span>';
        btn.remove();
      });
    </script>
  </body>
</html>
