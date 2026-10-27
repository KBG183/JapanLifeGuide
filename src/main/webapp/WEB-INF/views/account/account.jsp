<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title><fmt:message key="account.title"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="page-shell auth-shell">
  <section class="auth-card">
    <p class="eyebrow"><fmt:message key="account.start"/></p>
    <h1><fmt:message key="account.title"/></h1>
    <p class="muted"><fmt:message key="account.description"/></p>
    <c:if test="${not empty errorKey}"><p class="form-error"><fmt:message key="${errorKey}"/></p></c:if>
    <c:if test="${param.profileUpdated ne null}"><p class="form-success"><fmt:message key="account.profileUpdated"/></p></c:if>
    <c:if test="${param.passwordUpdated ne null}"><p class="form-success"><fmt:message key="account.passwordUpdated"/></p></c:if>

    <h2><fmt:message key="account.profileTitle"/></h2>
    <p><strong><fmt:message key="auth.login.id"/>:</strong> <c:out value="${member.loginId}"/></p>
    <p><strong><fmt:message key="auth.register.email"/>:</strong> <c:out value="${member.email}"/></p>
    <form action="<c:url value='/account/profile'/>" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <label for="account-display-name"><fmt:message key="auth.register.displayName"/></label>
      <input id="account-display-name" name="displayName" required maxlength="100" value="<c:out value='${member.displayName}'/>">
      <button class="button" type="submit"><fmt:message key="account.saveProfile"/></button>
    </form>

    <h2><fmt:message key="account.passwordTitle"/></h2>
    <form action="<c:url value='/account/password'/>" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <label for="current-password"><fmt:message key="account.currentPassword"/></label>
      <input id="current-password" name="currentPassword" type="password" required autocomplete="current-password">
      <label for="account-password"><fmt:message key="account.newPassword"/></label>
      <input id="account-password" name="password" type="password" required minlength="8" maxlength="72" autocomplete="new-password">
      <label for="account-password-confirm"><fmt:message key="auth.register.passwordConfirm"/></label>
      <input id="account-password-confirm" name="passwordConfirm" type="password" required minlength="8" maxlength="72" autocomplete="new-password">
      <button class="button" type="submit"><fmt:message key="account.savePassword"/></button>
    </form>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
