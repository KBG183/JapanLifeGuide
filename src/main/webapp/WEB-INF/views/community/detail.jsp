<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title><c:out value="${post.title}"/> | JAPAN LIFE GUIDE</title><c:url var="css" value="/css/app.css"/><c:url var="communityCss" value="/css/community.css"/><link rel="stylesheet" href="${css}"><link rel="stylesheet" href="${communityCss}"></head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="community-shell">
  <a class="text-link" href="<c:url value='/community'/>">← <fmt:message key="community.back"/></a>
  <c:if test="${param.reported ne null}"><p class="form-success community-notice" role="status"><fmt:message key="community.reportComplete"/></p></c:if>
  <article class="content-panel community-detail">
    <div class="post-meta"><span><fmt:message key="community.category.${post.category}"/></span></div>
    <h1><c:out value="${post.title}"/></h1>
    <div class="community-post-meta"><span><fmt:message key="community.views"/> ${post.view_count}</span></div>
    <p><c:out value="${post.body}"/></p>
    <c:forEach items="${images}" var="image"><c:url var="imageUrl" value="/community/images/${image.stored_name}"/><img class="community-image" src="${imageUrl}" alt="<c:out value='${image.original_name}'/>"></c:forEach>
    <div class="post-actions"><c:choose><c:when test="${not empty pageContext.request.userPrincipal}"><button class="like-button ${liked ? 'is-liked' : ''}" type="button" data-like-button data-like-url="<c:url value='/community/${post.id}/like'/>" data-csrf-name="${_csrf.parameterName}" data-csrf-token="${_csrf.token}" data-error="<fmt:message key='community.likeError'/>" aria-pressed="${liked}"><span data-like-label><fmt:message key="community.like"/></span> <span data-like-count>${post.like_count}</span></button><button class="bookmark-button ${bookmarked ? 'is-bookmarked' : ''}" type="button" data-bookmark-button data-bookmark-url="<c:url value='/community/${post.id}/bookmark'/>" data-csrf-name="${_csrf.parameterName}" data-csrf-token="${_csrf.token}" aria-pressed="${bookmarked}"><span data-bookmark-label><fmt:message key="community.bookmark"/></span></button></c:when><c:otherwise><c:url var="likeLoginUrl" value="/login"><c:param name="returnTo" value="/community/${post.id}"/></c:url><span class="community-login-like"><a href="${likeLoginUrl}"><fmt:message key="community.loginToLike"/></a></span></c:otherwise></c:choose></div>
    <c:if test="${not empty currentMemberId}"><div class="community-manage-actions"><c:choose><c:when test="${currentMemberId eq post.member_id}"><a class="text-link" href="<c:url value='/community/${post.id}/edit'/>"><fmt:message key="community.editPost"/></a><form method="post" action="<c:url value='/community/${post.id}/delete'/>"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><button class="text-button danger" type="submit" onclick="return confirm('<fmt:message key="community.deletePostConfirm"/>')"><fmt:message key="community.deletePost"/></button></form></c:when><c:otherwise><details class="community-report"><summary><fmt:message key="community.report"/></summary><form method="post" action="<c:url value='/community/${post.id}/report'/>"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><label><fmt:message key="community.reportReason"/><textarea name="reason" maxlength="500" required></textarea></label><button class="button" type="submit"><fmt:message key="community.reportSubmit"/></button></form></details></c:otherwise></c:choose></div></c:if>
  </article>
  <section class="content-panel community-comments">
    <div class="community-comments-heading"><h2><fmt:message key="community.comments"/></h2><span class="community-comment-count">${comments.size()}</span></div>
    <div class="community-comment-list">
      <c:forEach items="${comments}" var="comment">
        <article class="community-comment" data-comment-id="${comment.id}">
          <header class="community-comment-header"><div class="community-comment-author"><strong><c:out value="${comment.display_name}"/></strong><span class="community-comment-login">@<c:out value="${comment.login_id}"/></span></div><time><fmt:formatDate value="${comment.created_at}" pattern="yyyy.MM.dd HH:mm"/></time></header>
          <p class="community-comment-body"><c:out value="${comment.body}"/></p>
          <c:if test="${not empty currentMemberId}">
            <div class="community-comment-actions">
              <c:choose>
                <c:when test="${currentMemberId eq comment.member_id}">
                  <details><summary><fmt:message key="community.editComment"/></summary><form method="post" action="<c:url value='/community/comments/${comment.id}/edit'/>" data-comment-edit-form><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><input type="hidden" name="postId" value="${post.id}"><textarea name="body" maxlength="3000" required><c:out value="${comment.body}"/></textarea><button class="button" type="submit"><fmt:message key="community.saveEdit"/></button></form></details>
                  <form method="post" action="<c:url value='/community/comments/${comment.id}/delete'/>" data-comment-delete-form data-confirm="<fmt:message key='community.deleteCommentConfirm'/>"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><input type="hidden" name="postId" value="${post.id}"><button class="text-button danger" type="submit"><fmt:message key="community.deleteComment"/></button></form>
                </c:when>
                <c:otherwise>
                  <details class="community-report"><summary><fmt:message key="community.report"/></summary><form method="post" action="<c:url value='/community/comments/${comment.id}/report'/>"><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><input type="hidden" name="postId" value="${post.id}"><label><fmt:message key="community.reportReason"/><textarea name="reason" maxlength="500" required></textarea></label><button class="button" type="submit"><fmt:message key="community.reportSubmit"/></button></form></details>
                </c:otherwise>
              </c:choose>
            </div>
          </c:if>
        </article>
      </c:forEach>
    </div>
    <c:choose>
      <c:when test="${not empty pageContext.request.userPrincipal}">
        <c:if test="${param.commentError ne null}"><p class="form-error community-notice" role="alert" style="color: #c92a2a; margin-bottom: 1rem;"><fmt:message key="community.formError"/></p></c:if>
        <form class="community-comment-form" method="post" action="<c:url value='/community/${post.id}/comments'/>" data-comment-create-form><input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><textarea name="body" maxlength="3000" required placeholder="<fmt:message key='community.commentPlaceholder'/>"></textarea><button class="button" type="submit"><fmt:message key="community.commentSubmit"/></button></form>
      </c:when>
      <c:otherwise>
        <c:url var="commentLoginUrl" value="/login"><c:param name="returnTo" value="/community/${post.id}"/></c:url>
        <p class="community-login-like"><a href="${commentLoginUrl}"><fmt:message key="community.loginToComment"/></a></p>
      </c:otherwise>
    </c:choose>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
