<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width,initial-scale=1.0" />
    <title>ResQnet - General Public Overview</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/core.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/dashboard.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet" />
    <script src="https://unpkg.com/lucide@latest" defer></script>
    <style>
      h1 { margin:0 0 1rem; }
      .welcome { margin-bottom:1.2rem; }
      .alert.info { background:#fff5d6; border:1px solid #f0e0a8; color:#3a3320; display:flex; align-items:center; gap:0.6rem; padding:0.7rem 1rem; border-radius:12px; }
      .alert .alert-icon { width:18px; height:18px; }
      .quick-actions { display:grid; grid-template-columns:repeat(4,1fr); gap:1rem; margin:1rem 0 1.5rem; }
      .action-card { display:flex; flex-direction:column; align-items:center; justify-content:center; gap:0.6rem; padding:1.2rem; border:1px solid var(--color-border); border-radius:12px; background:#f6f6f6; cursor:pointer; }
      .action-card .action-icon i { width:24px; height:24px; }
      .safe-section { display:grid; grid-template-columns:1fr 1.2fr; gap:1rem; align-items:start; }
      .safe-list { display:flex; flex-direction:column; gap:0.6rem; }
      .safe-item { background:#f6f6f6; border:1px solid var(--color-border); border-radius:12px; padding:0.8rem 1rem; }
      .safe-item .name { font-weight:600; margin-bottom:0.15rem; }
      .map-shell { position:relative; border:1px solid var(--color-border); border-radius:12px; overflow:hidden; min-height:340px; background:#eaeaea; }
      .map-toolbar { position:absolute; right:0.75rem; top:0.75rem; background:#fff; border:1px solid var(--color-border); border-radius:999px; padding:0.25rem; display:flex; gap:0.25rem; }
      .map-search { position:absolute; left:0.75rem; top:0.75rem; background:#fff; border:1px solid var(--color-border); border-radius:999px; padding:0.35rem 0.6rem; display:flex; align-items:center; gap:0.4rem; }
      .map-iframe-holder { width:100%; height:100%; }
      @media (max-width:980px){ .safe-section { grid-template-columns:1fr; } }
    </style>
  </head>
  <body>
    <div class="layout">
      <aside class="sidebar" aria-label="Primary">
        <div class="brand"><img class="logo-img" src="${pageContext.request.contextPath}/static/assets/img/logo.svg" alt="ResQnet Logo" width="120" height="32" /><span class="brand-name sr-only">ResQnet</span></div>
        <nav class="nav">
          <button class="nav-item active" data-section="overview"><span class="icon" data-lucide="home"></span><span>Overview</span></button>
          <button class="nav-item" data-section="forecast"><span class="icon" data-lucide="line-chart"></span><span>Forecast Dashboard</span></button>
          <button class="nav-item" data-section="make-donation"><span class="icon" data-lucide="hand-coins"></span><span>Make a Donation</span></button>
          <button class="nav-item" data-section="request-donation"><span class="icon" data-lucide="package-plus"></span><span>Request a Donation</span></button>
          <button class="nav-item" data-section="report-disaster"><span class="icon" data-lucide="alert-octagon"></span><span>Report a Disaster</span></button>
          <button class="nav-item" data-section="be-volunteer"><span class="icon" data-lucide="user-plus"></span><span>Be a Volunteer</span></button>
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
        <div class="breadcrumb">General Public Dashboard / <span>Overview</span></div>
        <div class="topbar-right">
          <div class="hotline" role="button" tabindex="0" aria-label="Hotline 117"><span class="hotline-icon" data-lucide="phone"></span>Hotline: <strong>117</strong></div>
          <div class="user-avatar" aria-label="User Menu" role="button"><img src="https://via.placeholder.com/40x40.png?text=U" alt="User Avatar" /></div>
          <button class="menu-toggle" aria-label="Open Menu"><span data-lucide="menu"></span></button>
        </div>
      </header>
      <main class="content" id="mainContent" tabindex="-1">
        <section class="welcome">
          <h1>Welcome ${sessionScope.authUser.email}!</h1>
          <div class="alert info">
            <span class="alert-icon" data-lucide="alert-triangle"></span>
            <p>Heavy Rainfall Warning in Gampaha District – Next 48 Hours</p>
          </div>
        </section>
        <section class="quick">
          <div class="quick-actions">
            <button class="action-card" data-goto="make-donation.html"><div class="action-icon"><i data-lucide="gift"></i></div><span>Make a Donation</span></button>
            <button class="action-card" data-goto="request-donation.html"><div class="action-icon"><i data-lucide="package-plus"></i></div><span>Request a Donation</span></button>
            <button class="action-card" data-goto="report-disaster.html"><div class="action-icon"><i data-lucide="alert-octagon"></i></div><span>Report a Disaster</span></button>
            <button class="action-card" data-goto="be-volunteer.html"><div class="action-icon"><i data-lucide="user-plus"></i></div><span>Be a Volunteer</span></button>
          </div>
        </section>
        <section class="safe-section" aria-labelledby="safeHeading">
          <div>
            <h2 id="safeHeading" style="margin:0 0 0.8rem;">Safe Locations</h2>
            <div class="safe-list" id="safeList"></div>
          </div>
          <div>
            <div class="map-shell">
              <div class="map-search"><i data-lucide="search" style="width:16px;height:16px;"></i><span style="font-size:0.7rem;color:#666;">Search</span></div>
              <div class="map-toolbar"><button class="btn btn-icon" aria-label="Zoom In"><i data-lucide="plus"></i></button><button class="btn btn-icon" aria-label="Zoom Out"><i data-lucide="minus"></i></button></div>
              <div class="map-iframe-holder" id="mapHolder"></div>
            </div>
          </div>
        </section>
      </main>
    </div>

    <template id="safe-item-tmpl">
      <div class="safe-item"><div class="name"></div><div class="coords"></div></div>
    </template>

    <script>
      document.addEventListener('DOMContentLoaded', () => {
        if(window.lucide) lucide.createIcons();
        const list=[
          { name:'Central Park', coords:'40.7128° N, 74.0060° W' },
          { name:'Griffith Observatory', coords:'34.0522° N, 118.2437° W' },
          { name:'Eiffel Tower', coords:'48.8566° N, 2.3522° E' },
          { name:'Golden Gate Park', coords:'37.7749° N, 122.4194° W' }
        ];
        const wrap=document.getElementById('safeList'); const tmpl=document.getElementById('safe-item-tmpl');
        list.forEach(item=>{ const node=tmpl.content.firstElementChild.cloneNode(true); node.querySelector('.name').textContent=item.name; node.querySelector('.coords').textContent=item.coords; wrap.appendChild(node); });
      });
    </script>
  </body>
</html>
