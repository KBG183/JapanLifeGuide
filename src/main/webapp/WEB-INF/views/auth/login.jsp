<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title><fmt:message key="auth.login.title"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="page-shell auth-shell">
  <section class="auth-card">
    <p class="eyebrow"><fmt:message key="auth.login.start"/></p>
    <h1><fmt:message key="auth.login.title"/></h1>
    <c:if test="${param.error ne null}"><p class="form-error"><fmt:message key="auth.login.error"/></p></c:if>
    <c:if test="${not empty param.registered}"><p class="form-success"><fmt:message key="auth.login.success"/></p></c:if>
    <c:if test="${not empty param.passwordReset}"><p class="form-success"><fmt:message key="auth.passwordReset.success"/></p></c:if>
    <form action="<c:url value='/login'/>" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <input type="hidden" name="returnTo" value="<c:out value='${loginReturnTo}'/>">
      <label for="username"><fmt:message key="auth.login.id"/></label>
      <input id="username" name="username" required maxlength="60" autocomplete="username">
      <label for="password"><fmt:message key="auth.login.password"/></label>
      <input id="password" name="password" type="password" required autocomplete="current-password">
      <button class="button" type="submit"><fmt:message key="auth.login.submit"/></button>
    </form>
    <p class="auth-foot"><a href="<c:url value='/find-login-id'/>"><fmt:message key="auth.findLoginId.link"/></a></p>
    <p class="auth-foot"><a href="<c:url value='/forgot-password'/>"><fmt:message key="auth.passwordReset.link"/></a></p>
    <p class="auth-foot"><fmt:message key="auth.login.noAccount"/> <a href="<c:url value='/register'/>"><fmt:message key="nav.register"/></a></p>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
