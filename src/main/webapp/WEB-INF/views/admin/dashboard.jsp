<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<c:set var="adminSection" value="dashboard"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><fmt:message key="admin.dashboard"/> | JAPAN LIFE GUIDE</title><c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}"></head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="admin-layout">
  <%@ include file="admin-nav.jspf" %>
  <section class="admin-main">
    <c:set var="openReports" value="0"/><c:forEach items="${reports}" var="report"><c:if test="${report.status == 'OPEN'}"><c:set var="openReports" value="${openReports + 1}"/></c:if></c:forEach>
    <header class="admin-main-header"><div><p class="eyebrow"><fmt:message key="admin.eyebrow"/></p><h1><fmt:message key="admin.dashboard"/></h1><p><fmt:message key="admin.choose"/></p></div><span class="admin-time"><fmt:message key="admin.overview"/></span></header>
    <section class="admin-stat-grid" aria-label="<fmt:message key='admin.summary'/>">
      <article class="admin-stat-card"><p><fmt:message key="admin.totalMembers"/></p><strong>${members.size()}</strong><a href="<c:url value='/admin/members'/>"><fmt:message key="admin.manage"/> →</a></article>
      <article class="admin-stat-card"><p><fmt:message key="admin.publishedProcedures"/></p><strong>${publishedProcedureCount}</strong><a href="<c:url value='/admin/procedures'/>"><fmt:message key="admin.manage"/> →</a></article>
      <article class="admin-stat-card"><p><fmt:message key="admin.communityPostsCount"/></p><strong>${communityPosts.size()}</strong><a href="<c:url value='/admin/community'/>"><fmt:message key="admin.manage"/> →</a></article>
      <article class="admin-stat-card"><p><fmt:message key="admin.openReports"/></p><strong>${openReports}</strong><a href="<c:url value='/admin/reports'/>"><fmt:message key="admin.manage"/> →</a></article>
    </section>
    <div class="admin-dashboard-grid">
      <section class="admin-dashboard-panel"><h2><fmt:message key="admin.needsAttention"/></h2><c:choose><c:when test="${openReports > 0}"><div class="admin-alert-row"><div><strong><fmt:message key="community.reports"/></strong><br><span><fmt:message key="admin.openReportsDescription"/></span></div><a class="button" href="<c:url value='/admin/reports'/>"><fmt:message key="admin.review"/></a></div></c:when><c:otherwise><p class="admin-empty"><fmt:message key="admin.noAttention"/></p></c:otherwise></c:choose></section>
      <section class="admin-dashboard-panel"><h2><fmt:message key="admin.recentPosts"/></h2><c:choose><c:when test="${not empty communityPosts}"><c:forEach items="${communityPosts}" var="post" varStatus="status"><c:if test="${status.index < 5}"><div class="admin-recent-row"><a href="<c:url value='/community/${post.id}'/>"><c:out value="${post.title}"/></a><span><fmt:message key="community.views"/> ${post.view_count}</span></div></c:if></c:forEach></c:when><c:otherwise><p class="admin-empty"><fmt:message key="community.empty"/></p></c:otherwise></c:choose></section>
    </div>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
