<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/><fmt:setBundle basename="messages/messages"/>
<!DOCTYPE html><html lang="${currentLanguage}"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width, initial-scale=1"><title>JAPAN LIFE GUIDE</title><c:url var="css" value="/css/app.css"/><link rel="stylesheet" href="${css}"></head><body><%@ include file="../fragments/header.jspf" %><main id="main" class="page-shell"><section class="empty-state error-state"><p class="eyebrow">${statusCode}</p><h1><fmt:message key="${errorTitleKey}"/></h1><p><fmt:message key="${errorDescriptionKey}"/></p><a class="button" href="${homeUrl}"><fmt:message key="error.back"/></a></section></main><%@ include file="../fragments/footer.jspf" %></body></html>
