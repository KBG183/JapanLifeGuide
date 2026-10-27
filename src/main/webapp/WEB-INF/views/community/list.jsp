<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><fmt:message key="community.title"/> | JAPAN LIFE GUIDE</title><c:url var="css" value="/css/app.css"/><c:url var="communityCss" value="/css/community.css"/><link rel="stylesheet" href="${css}"><link rel="stylesheet" href="${communityCss}"></head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="community-shell">
  <section class="community-hero"><div><p class="eyebrow">JAPAN LIFE GUIDE COMMUNITY</p><h1><fmt:message key="community.title"/></h1><p><fmt:message key="community.description"/></p></div><a class="button" href="<c:url value='/community/write'/>"><fmt:message key="community.write"/></a></section>
  <div class="community-layout">
    <aside class="community-sidebar">
      <a class="community-nav ${empty category?'active':''}" href="<c:url value='/community'/>"><fmt:message key="community.all"/></a>
      <c:forEach items="${['ADMIN','HOME','STUDENT','WORK','MEETUP','GENERAL']}" var="cat"><a class="community-nav ${category==cat?'active':''}" href="<c:url value='/community?category=${cat}'/>"><fmt:message key="community.category.${cat}"/></a></c:forEach>
    </aside>
    <section class="community-feed">
      <div class="community-toolbar"><strong><fmt:message key="community.recent"/></strong><form class="community-search" method="get" action="<c:url value='/community'/>"><c:if test="${not empty category}"><input type="hidden" name="category" value="${category}"></c:if><input name="q" value="<c:out value='${q}'/>" maxlength="80" placeholder="<fmt:message key='community.searchPlaceholder'/>"><button class="button secondary" type="submit"><fmt:message key="community.search"/></button></form></div>
      <c:forEach items="${posts}" var="p"><article class="community-post"><div class="post-body"><div class="post-meta"><span><fmt:message key="community.category.${p.category}"/></span></div><h2><a href="<c:url value='/community/${p.id}'/>"><c:out value="${p.title}"/></a></h2><p><c:out value="${p.body}"/></p><div class="post-actions"><span><fmt:message key="community.comments"/> ${p.comment_count}</span><span><fmt:message key="community.likes"/> ${p.like_count}</span><span><fmt:message key="community.views"/> ${p.view_count}</span></div></div></article></c:forEach>
      <c:if test="${empty posts}"><div class="empty-state"><p><fmt:message key="community.empty"/></p></div></c:if>
      <c:if test="${pages > 1}"><nav class="community-pagination" aria-label="<fmt:message key='community.pagination'/>"><c:if test="${page > 1}"><c:url var="prevUrl" value="/community"><c:param name="category" value="${category}"/><c:param name="q" value="${q}"/><c:param name="page" value="${page - 1}"/></c:url><a href="${prevUrl}">← <fmt:message key="community.previous"/></a></c:if><span>${page} / ${pages}</span><c:if test="${page < pages}"><c:url var="nextUrl" value="/community"><c:param name="category" value="${category}"/><c:param name="q" value="${q}"/><c:param name="page" value="${page + 1}"/></c:url><a href="${nextUrl}"><fmt:message key="community.next"/> →</a></c:if></nav></c:if>
    </section>
  </div>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
