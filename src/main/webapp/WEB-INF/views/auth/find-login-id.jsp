<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title><fmt:message key="auth.findLoginId.title"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="page-shell auth-shell">
  <section class="auth-card">
    <p class="eyebrow"><fmt:message key="auth.findLoginId.start"/></p>
    <h1><fmt:message key="auth.findLoginId.title"/></h1>
    <p class="muted"><fmt:message key="auth.findLoginId.description"/></p>
    <form id="find-login-id-form" action="<c:url value='/find-login-id/verify-code'/>" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <label for="find-login-id-email"><fmt:message key="auth.register.email"/></label>
      <input id="find-login-id-email" name="email" type="email" required maxlength="254" autocomplete="email">
      <button id="send-find-login-id-code" class="button button-secondary" type="button" data-send-url="<c:url value='/find-login-id/send-code'/>" data-sent="<fmt:message key='auth.findLoginId.codeSent'/>" data-cooldown="<fmt:message key='auth.findLoginId.cooldown'/>" data-error="<fmt:message key='auth.findLoginId.mailError'/>"><fmt:message key="auth.findLoginId.sendCode"/></button>
      <div class="login-id-check-row">
        <input id="find-login-id-code" name="code" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" placeholder="<fmt:message key='auth.register.emailCodePlaceholder'/>" required>
        <button id="verify-find-login-id-code" class="button button-secondary" type="button" data-verify-url="<c:url value='/find-login-id/verify-code'/>" data-success="<fmt:message key='auth.findLoginId.verified'/>" data-error="<fmt:message key='auth.findLoginId.codeInvalid'/>" data-result="<fmt:message key='auth.findLoginId.result'/>"><fmt:message key="auth.findLoginId.verifyCode"/></button>
      </div>
      <p id="find-login-id-status" class="form-status" aria-live="polite"></p>
      <p id="found-login-id" class="form-success" hidden></p>
    </form>
    <p class="auth-foot"><a href="<c:url value='/login'/>"><fmt:message key="nav.login"/></a></p>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
