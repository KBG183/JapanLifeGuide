<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title><fmt:message key="auth.passwordReset.title"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="page-shell auth-shell">
  <section class="auth-card">
    <p class="eyebrow"><fmt:message key="auth.passwordReset.start"/></p>
    <h1><fmt:message key="auth.passwordReset.title"/></h1>
    <p class="muted"><fmt:message key="auth.passwordReset.description"/></p>
    <c:if test="${not empty errorKey}"><p class="form-error"><fmt:message key="${errorKey}"/></p></c:if>
    <form id="password-reset-form" action="<c:url value='/forgot-password/reset'/>" method="post" data-reset-invalid="<fmt:message key='auth.passwordReset.passwordInvalid'/>">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <label for="reset-login-id"><fmt:message key="auth.login.id"/></label>
      <input id="reset-login-id" name="loginId" required maxlength="60" autocomplete="username">
      <label for="reset-email"><fmt:message key="auth.register.email"/></label>
      <input id="reset-email" name="email" type="email" required maxlength="254" autocomplete="email">
      <div class="login-id-check-row">
        <button id="send-reset-code" class="button button-secondary" type="button" data-send-url="<c:url value='/forgot-password/send-code'/>" data-sent="<fmt:message key='auth.passwordReset.codeSent'/>" data-cooldown="<fmt:message key='auth.passwordReset.cooldown'/>" data-error="<fmt:message key='auth.passwordReset.mailError'/>"><fmt:message key="auth.passwordReset.sendCode"/></button>
      </div>
      <div class="login-id-check-row">
        <input id="reset-code" name="code" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" placeholder="<fmt:message key='auth.register.emailCodePlaceholder'/>">
        <button id="verify-reset-code" class="button button-secondary" type="button" data-verify-url="<c:url value='/forgot-password/verify-code'/>" data-success="<fmt:message key='auth.passwordReset.codeVerified'/>" data-error="<fmt:message key='auth.passwordReset.codeInvalid'/>" data-required="<fmt:message key='auth.passwordReset.verificationRequired'/>"><fmt:message key="auth.passwordReset.verifyCode"/></button>
      </div>
      <p id="password-reset-status" class="form-status" aria-live="polite"></p>
      <label for="reset-password"><fmt:message key="auth.login.password"/></label>
      <input id="reset-password" name="password" type="password" required minlength="8" maxlength="72" autocomplete="new-password">
      <label for="reset-password-confirm"><fmt:message key="auth.register.passwordConfirm"/></label>
      <input id="reset-password-confirm" name="passwordConfirm" type="password" required minlength="8" maxlength="72" autocomplete="new-password">
      <button class="button" type="submit"><fmt:message key="auth.passwordReset.submit"/></button>
    </form>
    <p class="auth-foot"><a href="<c:url value='/login'/>"><fmt:message key="nav.login"/></a></p>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
