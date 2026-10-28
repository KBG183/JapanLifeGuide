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
  <title><fmt:message key="community.write"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/>
  <link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="community-shell">
  <section class="content-panel">
    <h1><fmt:message key="community.write"/></h1>
    <c:if test="${formError}">
      <p class="form-error community-notice" role="alert" style="color: #c92a2a; margin-bottom: 1rem; font-weight: 500;">
        <fmt:message key="community.formError"/>
      </p>
    </c:if>
    <form class="community-write-form" method="post" enctype="multipart/form-data" action="<c:url value='/community/write'/>">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <label><fmt:message key="community.category"/>
        <select name="category">
          <c:forEach items="${['GENERAL','ADMIN','HOME','STUDENT','WORK','MEETUP']}" var="cat">
            <option value="${cat}" ${form.category == cat ? 'selected' : ''}><fmt:message key="community.category.${cat}"/></option>
          </c:forEach>
        </select>
      </label>
      <label><fmt:message key="community.subject"/>
        <input name="title" maxlength="200" value="<c:out value='${form.title}'/>" required>
      </label>
      <label><fmt:message key="community.body"/>
        <textarea name="body" maxlength="10000" required><c:out value="${form.body}"/></textarea>
      </label>
      <label><fmt:message key="community.images"/>
        <input type="file" name="images" accept="image/jpeg,image/png,image/gif,image/webp" multiple>
      </label>
      <button class="button" type="submit"><fmt:message key="community.submit"/></button>
    </form>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
