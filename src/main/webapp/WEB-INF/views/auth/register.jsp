<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
  <meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1">
  <title><fmt:message key="auth.register.title"/> | JAPAN LIFE GUIDE</title>
  <c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="page-shell auth-shell">
  <section class="auth-card">
    <p class="eyebrow"><fmt:message key="auth.register.start"/></p>
    <h1><fmt:message key="auth.register.title"/></h1>
    <p class="muted"><fmt:message key="auth.register.description"/></p>
    <c:if test="${not empty errorKey}"><p class="form-error"><fmt:message key="${errorKey}"/></p></c:if>
    <form action="<c:url value='/register'/>" method="post" data-focus-field="${focusField}"
      data-email-invalid="<fmt:message key='auth.register.emailInvalid'/>">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
      <input id="loginIdChecked" name="loginIdChecked" type="hidden" value="${loginIdChecked}">
      <input id="emailVerified" type="hidden" value="${emailVerified}">
      <label for="loginId"><fmt:message key="auth.login.id"/></label>
      <div class="login-id-check-row">
        <input id="loginId" name="loginId" required maxlength="60" pattern="[A-Za-z0-9._-]{4,60}" autocomplete="username" value="<c:out value='${loginId}'/>">
        <button id="check-login-id" class="button button-secondary" type="button"
          data-check-url="<c:url value='/register/check-login-id'/>"
          data-available="<fmt:message key='auth.register.loginIdAvailable'/>"
          data-duplicate="<fmt:message key='auth.register.loginIdDuplicate'/>"
          data-invalid="<fmt:message key='auth.register.loginIdInvalid'/>"
          data-required="<fmt:message key='auth.register.loginIdCheckRequired'/>"
          data-checking="<fmt:message key='auth.register.loginIdChecking'/>"
          data-error="<fmt:message key='auth.register.loginIdCheckError'/>">
          <fmt:message key="auth.register.checkLoginId"/>
        </button>
      </div>
      <p id="login-id-status" class="form-status" aria-live="polite"></p>
      <label for="email"><fmt:message key="auth.register.email"/></label>
      <div class="login-id-check-row">
        <input id="email" name="email" type="email" required maxlength="254" autocomplete="email" value="<c:out value='${email}'/>">
        <button id="check-email" class="button button-secondary" type="button" data-check-url="<c:url value='/register/check-email'/>" data-available="<fmt:message key='auth.register.emailAvailable'/>" data-duplicate="<fmt:message key='auth.register.emailDuplicate'/>"><fmt:message key="auth.register.checkEmail"/></button>
      </div>
      <p id="email-status" class="form-status" aria-live="polite"></p>
      <div class="login-id-check-row">
        <input id="email-code" name="emailCode" inputmode="numeric" pattern="[0-9]{6}" maxlength="6" placeholder="<fmt:message key='auth.register.emailCodePlaceholder'/>">
        <button id="send-email-code" class="button button-secondary" type="button" data-send-url="<c:url value='/register/send-email-code'/>" data-sent="<fmt:message key='auth.register.emailCodeSent'/>" data-cooldown="<fmt:message key='auth.register.emailCooldown'/>" data-error="<fmt:message key='auth.register.emailMailError'/>"><fmt:message key="auth.register.sendEmailCode"/></button>
        <button id="verify-email-code" class="button button-secondary" type="button" data-verify-url="<c:url value='/register/verify-email-code'/>" data-success="<fmt:message key='auth.register.emailCodeVerified'/>" data-error="<fmt:message key='auth.register.emailCodeInvalid'/>" data-required="<fmt:message key='auth.register.emailVerificationRequired'/>"><fmt:message key="auth.register.verifyEmailCode"/></button>
      </div>
      <p id="email-code-status" class="form-status" aria-live="polite"></p>
      <label for="displayName"><fmt:message key="auth.register.displayName"/></label>
      <input id="displayName" name="displayName" required maxlength="100" value="<c:out value='${displayName}'/>">
      <label for="password"><fmt:message key="auth.register.passwordHint"/></label>
      <input id="password" name="password" type="password" required minlength="8" maxlength="72" autocomplete="new-password">
      <label for="passwordConfirm"><fmt:message key="auth.register.passwordConfirm"/></label>
      <input id="passwordConfirm" name="passwordConfirm" type="password" required minlength="8" maxlength="72" autocomplete="new-password" <c:if test="${focusField eq 'passwordConfirm'}">autofocus</c:if>>
      <button class="button" type="submit"><fmt:message key="auth.register.submit"/></button>
    </form>
    <p class="auth-foot"><fmt:message key="auth.register.hasAccount"/> <a href="<c:url value='/login'/>"><fmt:message key="nav.login"/></a></p>
  </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
