<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<c:set var="adminSection" value="community"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><fmt:message key="admin.communityPosts"/> | JAPAN LIFE GUIDE</title><c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}"></head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="admin-layout">
  <%@ include file="admin-nav.jspf" %>
  <section class="admin-main">
    <header class="admin-page-header"><div><p class="eyebrow"><fmt:message key="admin.communityGroup"/></p><h1><fmt:message key="admin.communityPosts"/></h1></div><a class="button secondary" href="<c:url value='/community'/>"><fmt:message key="admin.openPublicPage"/></a></header>
    <form class="admin-filter" method="get" action="<c:url value='/admin/community'/>"><div class="field"><label for="q"><fmt:message key="admin.search"/></label><input id="q" name="q" value="<c:out value='${q}'/>" maxlength="80"></div><div class="field"><label for="category"><fmt:message key="community.category"/></label><select id="category" name="category"><option value=""><fmt:message key="admin.allCategories"/></option><c:forEach items="${['ADMIN','HOME','STUDENT','WORK','MEETUP','GENERAL']}" var="cat"><option value="${cat}" ${category == cat ? 'selected' : ''}><fmt:message key="community.category.${cat}"/></option></c:forEach></select></div><button class="button" type="submit"><fmt:message key="admin.filter"/></button></form>
    <section class="content-panel"><div class="admin-table-wrap"><table class="admin-table"><thead><tr><th>ID</th><th><fmt:message key="community.category"/></th><th><fmt:message key="community.subject"/></th><th><fmt:message key="admin.author"/></th><th><fmt:message key="community.views"/></th><th><fmt:message key="community.likes"/></th><th><fmt:message key="community.comments"/></th><th><fmt:message key="admin.status"/></th><th><fmt:message key="admin.actions"/></th></tr></thead><tbody><c:forEach items="${posts}" var="p"><tr><td>${p.id}</td><td><fmt:message key="community.category.${p.category}"/></td><td><a href="<c:url value='/community/${p.id}'/>"><c:out value="${p.title}"/></a></td><td><c:out value="${p.login_id}"/></td><td>${p.view_count}</td><td>${p.like_count}</td><td>${p.comment_count}</td><td><span class="admin-status ${p.status == 'HIDDEN' ? 'hidden' : p.status == 'DELETED' ? 'deleted' : ''}">${p.status}</span></td><td><form class="admin-inline-form" method="post" action="<c:url value='/admin/community/posts/${p.id}/status'/>"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><select name="status"><option value="ACTIVE" ${p.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option><option value="HIDDEN" ${p.status == 'HIDDEN' ? 'selected' : ''}>HIDDEN</option><option value="DELETED" ${p.status == 'DELETED' ? 'selected' : ''}>DELETED</option></select><button class="button" type="submit"><fmt:message key="admin.saveStatus"/></button></form></td></tr></c:forEach></tbody></table></div><c:if test="${empty posts}"><p class="admin-empty"><fmt:message key="admin.noPosts"/></p></c:if></section>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
