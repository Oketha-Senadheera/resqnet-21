<%@ tag description="DMC dashboard layout" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags/layouts" %>
<%@ attribute name="pageTitle" required="false" %>
<%@ attribute name="activePage" required="false" %>
<%@ attribute name="styles" fragment="true" required="false" %>
<%@ attribute name="scripts" fragment="true" required="false" %>
<%
  // Make active page effectively final
  final String activePageRaw = (String) jspContext.getAttribute("activePage");
  final String activePageVal = (activePageRaw != null) ? activePageRaw : "overview";

  // Build nav items without double-brace initialization
  java.util.List<java.util.Map<String, Object>> navItems = new java.util.ArrayList<>();
  java.util.Map<String, Object> item;

  item = new java.util.HashMap<>();
  item.put("section", "overview");
  item.put("icon", "home");
  item.put("label", "Overview");
  item.put("link", "dmc/overview");
  item.put("active", "overview".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "forecast");
  item.put("icon", "line-chart");
  item.put("label", "Forecast Dashboard");
  item.put("link", "dmc/forecast");
  item.put("active", "forecast".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "disaster-reports");
  item.put("icon", "file-text");
  item.put("label", "Disaster Reports");
  item.put("link", "dmc/disaster-reports");
  item.put("active", "disaster-reports".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "volunteer-apps");
  item.put("icon", "users");
  item.put("label", "Volunteer Applications");
  item.put("link", "dmc/volunteer-apps");
  item.put("active", "volunteer-apps".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "delivery-confirmations");
  item.put("icon", "check-square");
  item.put("label", "Delivery Confirmations");
  item.put("link", "dmc/delivery-confirmations");
  item.put("active", "delivery-confirmations".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "safe-locations");
  item.put("icon", "map-pin");
  item.put("label", "Safe Locations");
  item.put("link", "dmc/safe-locations");
  item.put("active", "safe-locations".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "gn-registry");
  item.put("icon", "list");
  item.put("label", "GN Registry");
  item.put("link", "dmc/gn-registry");
  item.put("active", "gn-registry".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "forum");
  item.put("icon", "message-circle");
  item.put("label", "Forum");
  item.put("link", "dmc/forum");
  item.put("active", "forum".equals(activePageVal));
  navItems.add(item);

  item = new java.util.HashMap<>();
  item.put("section", "profile-settings");
  item.put("icon", "user");
  item.put("label", "Profile Settings");
  item.put("link", "dmc/profile-settings");
  item.put("active", "profile-settings".equals(activePageVal));
  navItems.add(item);

  jspContext.setAttribute("navItems", navItems);

  String titleVal = (String) jspContext.getAttribute("pageTitle");
  if (titleVal == null) titleVal = "ResQnet - DMC Overview";
  jspContext.setAttribute("finalTitle", titleVal);

  String breadcrumbVal = "DMC Dashboard / <span>" +
    (activePageVal.substring(0, 1).toUpperCase() + activePageVal.substring(1).replace("-", " ")) +
    "</span>";
  jspContext.setAttribute("finalBreadcrumb", breadcrumbVal);
%>
<layout:dashboard title="${finalTitle}" role="dmc" breadcrumb="${finalBreadcrumb}" navItems="${navItems}">
  <jsp:attribute name="styles">
    <c:if test="${not empty styles}">
      <jsp:invoke fragment="styles" />
    </c:if>
  </jsp:attribute>
  <jsp:attribute name="scripts">
    <c:if test="${not empty scripts}">
      <jsp:invoke fragment="scripts" />
    </c:if>
  </jsp:attribute>
  <jsp:body>
    <jsp:doBody />
  </jsp:body>
</layout:dashboard>
