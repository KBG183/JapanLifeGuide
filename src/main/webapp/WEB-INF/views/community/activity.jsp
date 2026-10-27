<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/>
<fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title><fmt:message key="community.myActivity"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/>
  <link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="page-shell">
  <h1><fmt:message key="community.myActivity"/></h1>
  <section class="content-panel">
    <h2><fmt:message key="community.bookmarks"/></h2>
    <c:choose>
      <c:when test="${empty bookmarks}">
        <p><fmt:message key="community.noBookmarks"/></p>
      </c:when>
      <c:otherwise>
        <ul class="activity-list">
          <c:forEach items="${bookmarks}" var="post">
            <li>
              <a href="<c:url value='/community/${post.id}'/>"><c:out value="${post.title}"/></a>
              <span><fmt:message key="community.comments"/> ${post.comment_count} · <fmt:message key="community.likes"/> ${post.like_count}</span>
            </li>
          </c:forEach>
        </ul>
      </c:otherwise>
    </c:choose>
  </section>
  <section class="content-panel">
    <div class="section-header-row">
      <h2><fmt:message key="community.notifications"/></h2>
      <c:if test="${unreadNotificationCount > 0}">
        <form method="post" action="<c:url value='/my/community/notifications/read-all'/>" class="inline-form">
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
          <button class="text-button" type="submit"><fmt:message key="community.markAllRead"/></button>
        </form>
      </c:if>
    </div>
    <c:choose>
      <c:when test="${empty notifications}">
        <p><fmt:message key="community.noNotifications"/></p>
      </c:when>
      <c:otherwise>
        <ul class="activity-list">
          <c:forEach items="${notifications}" var="notification">
            <li class="${empty notification.read_at ? 'is-unread' : ''}">
              <span><fmt:message key="community.notification.comment"/></span>
              <c:if test="${not empty notification.post_id}">
                <a href="<c:url value='/community/${notification.post_id}'/>"><fmt:message key="community.openPost"/></a>
              </c:if>
              <c:if test="${empty notification.read_at}">
                <form method="post" action="<c:url value='/my/community/notifications/${notification.id}/read'/>">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                  <button class="text-button" type="submit"><fmt:message key="community.markRead"/></button>
                </form>
              </c:if>
            </li>
          </c:forEach>
        </ul>
      </c:otherwise>
    </c:choose>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
