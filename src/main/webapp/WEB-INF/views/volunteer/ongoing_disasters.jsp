<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>

<layout:volunteer-dashboard pageTitle="Ongoing Disasters" activePage="ongoing-disasters">
    <jsp:attribute name="styles">
        <style>
            .disaster-grid { display: grid; gap: 1.5rem; }
            .disaster-card {
                background: white; border: 1px solid var(--color-border); border-radius: 12px; padding: 1.5rem;
                display: flex; flex-direction: column; gap: 1rem;
            }
            .disaster-header { display: flex; justify-content: space-between; align-items: start; }
            .disaster-title { font-size: 1.1rem; font-weight: 600; color: var(--color-text-main); }
            .status-badge {
                padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.75rem; font-weight: 600;
                text-transform: uppercase;
            }
            .status-badge.pending { background: #fff5d6; color: #b08800; }
            .status-badge.active { background: #dcfce7; color: #166534; }
            
            .meta-info { font-size: 0.85rem; color: var(--color-text-sub); display: flex; gap: 1rem; flex-wrap: wrap; }
            .meta-item { display: flex; align-items: center; gap: 0.4rem; }
            .meta-item i { width: 16px; height: 16px; }
            
            .action-area { margin-top: auto; padding-top: 1rem; border-top: 1px solid var(--color-border); }
            .assist-form { display: flex; justify-content: flex-end; }
            .btn-assist {
                background: var(--color-primary); color: white; border: none; padding: 0.6rem 1.2rem;
                border-radius: 8px; font-weight: 600; cursor: pointer; transition: opacity 0.2s;
            }
            .btn-assist:hover { opacity: 0.9; }
            
            .active-area { display: flex; flex-direction: column; gap: 0.8rem; }
            .notes-input {
                width: 100%; border: 1px solid var(--color-border); border-radius: 8px; padding: 0.8rem;
                font-family: inherit; font-size: 0.9rem; resize: vertical; min-height: 80px;
            }
            .btn-save {
                background: var(--color-success, #22c55e); color: white; border: none; padding: 0.5rem 1rem;
                border-radius: 6px; font-weight: 600; cursor: pointer; align-self: flex-end;
            }
        </style>
    </jsp:attribute>

    <jsp:body>
        <h1 class="page-title">Ongoing Disasters</h1>
        
        <c:if test="${not empty sessionScope.flashMessage}">
            <div class="alert success" style="background:#dcfce7; color:#166534; padding:1rem; border-radius:8px; margin-bottom:1.5rem;">
                ${sessionScope.flashMessage}
            </div>
            <c:remove var="flashMessage" scope="session"/>
        </c:if>
        
        <c:if test="${empty approvedReports}">
            <div class="empty-state" style="text-align:center; padding:3rem; color:var(--color-text-sub);">
                <i data-lucide="check-circle" style="width:48px; height:48px; margin-bottom:1rem; opacity:0.5;"></i>
                <p>No verified ongoing disasters at the moment.</p>
            </div>
        </c:if>

        <div class="disaster-grid">
            <c:forEach items="${approvedReports}" var="report">
                <div class="disaster-card">
                    <div class="disaster-header">
                        <div>
                            <div class="disaster-title">${report.disasterType}: ${report.location}</div>
                            <div class="meta-info" style="margin-top:0.5rem;">
                                <span class="meta-item"><i data-lucide="calendar"></i> ${report.disasterDatetime}</span>
                                <span class="meta-item"><i data-lucide="user"></i> ${report.reporterName}</span>
                            </div>
                        </div>
                        <c:set var="myAssignment" value="${assignmentMap[report.reportId]}" />
                        <span class="status-badge ${not empty myAssignment ? 'active' : 'pending'}">
                            ${not empty myAssignment ? 'Assisting' : 'Needs Help'}
                        </span>
                    </div>
                    
                    <p style="color:var(--color-text-sub); line-height:1.5;">${report.description}</p>
                    
                    <div class="action-area">
                        <c:choose>
                            <c:when test="${not empty myAssignment}">
                                <div class="active-area">
                                    <div style="font-weight:600; font-size:0.9rem; color:var(--color-text-main);">My Updates</div>
                                    <form action="${pageContext.request.contextPath}/volunteer/ongoing-disasters" method="post">
                                        <input type="hidden" name="action" value="update_notes">
                                        <input type="hidden" name="reportId" value="${report.reportId}">
                                        <input type="hidden" name="assignmentId" value="${myAssignment.assignmentId}">
                                        <textarea name="notes" class="notes-input" placeholder="Add notes about your assistance...">${myAssignment.notes}</textarea>
                                        <button type="submit" class="btn-save">Save Updates</button>
                                    </form>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <form action="${pageContext.request.contextPath}/volunteer/ongoing-disasters" method="post" class="assist-form">
                                    <input type="hidden" name="action" value="assist">
                                    <input type="hidden" name="reportId" value="${report.reportId}">
                                    <button type="submit" class="btn-assist">I Will Assist</button>
                                </form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </jsp:body>
</layout:volunteer-dashboard>
