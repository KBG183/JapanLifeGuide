<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/>
<fmt:setBundle basename="messages/messages"/>
<c:set var="adminSection" value="documents"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title><fmt:message key="admin.translations"/> - <c:out value="${document.name}"/> | JAPAN LIFE GUIDE</title>
    <c:url var="css" value="/css/app.css"/>
    <link rel="stylesheet" href="${css}">
</head>
<body>
<%@ include file="../fragments/header.jspf" %>
<main id="main" class="admin-layout">
    <%@ include file="admin-nav.jspf" %>
    <section class="admin-main">
        <header class="admin-page-header">
            <div>
                <p class="eyebrow"><fmt:message key="admin.contentGroup"/> &gt; <fmt:message key="admin.documents"/></p>
                <h1><fmt:message key="admin.translations"/>: <c:out value="${document.name}"/> (#${document.id})</h1>
            </div>
            <div>
                <a href="<c:url value='/admin/documents'/>" class="button-outline"><fmt:message key="admin.backToList"/></a>
            </div>
        </header>

        <c:if test="${not empty param.saved}">
            <div class="alert alert-success" style="background:#e6f4ea; border:1px solid #ceead6; color:#137333; padding:12px 16px; border-radius:6px; margin-bottom:20px;">
                <fmt:message key="admin.translationSaved"/> (${param.saved})
            </div>
        </c:if>

        <section class="content-panel">
            <div class="reference-box">
                <h3 style="margin-top:0; margin-bottom:12px; font-size:15px; color:#2d3748;"><fmt:message key="admin.originalJapanese"/></h3>
                <dl>
                    <dt>Procedure (手続き):</dt>
                    <dd><c:out value="${document.procedure_title}"/> (#${document.procedure_id})</dd>
                    <dt>Document Name (書類名):</dt>
                    <dd><c:out value="${document.name}"/></dd>
                    <dt>Requirement (必須/条件):</dt>
                    <dd><c:out value="${document.requirement}"/></dd>
                    <dt>Condition (条件詳細):</dt>
                    <dd><c:out value="${document.condition_text}" default="-"/></dd>
                </dl>
            </div>

            <div class="translation-grid">
                <!-- Korean Translation Card -->
                <div class="translation-card">
                    <h3><fmt:message key="admin.translationKo"/></h3>
                    <form action="<c:url value='/admin/documents/${document.id}/translations'/>" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="lang" value="ko">

                        <div class="field-group">
                            <label for="ko_name">Document Name (서류명) *</label>
                            <input type="text" id="ko_name" name="name" required maxlength="200" value="<c:out value='${translations[\"ko\"].name}'/>">
                        </div>
                        <div class="field-group">
                            <label for="ko_condition">Condition (조건 안내)</label>
                            <textarea id="ko_condition" name="conditionText" maxlength="1000"><c:out value="${translations['ko'].condition_text}"/></textarea>
                        </div>

                        <button type="submit" class="button"><fmt:message key="admin.saveTranslation"/></button>
                    </form>
                </div>

                <!-- English Translation Card -->
                <div class="translation-card">
                    <h3><fmt:message key="admin.translationEn"/></h3>
                    <form action="<c:url value='/admin/documents/${document.id}/translations'/>" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="lang" value="en">

                        <div class="field-group">
                            <label for="en_name">Document Name *</label>
                            <input type="text" id="en_name" name="name" required maxlength="200" value="<c:out value='${translations[\"en\"].name}'/>">
                        </div>
                        <div class="field-group">
                            <label for="en_condition">Condition</label>
                            <textarea id="en_condition" name="conditionText" maxlength="1000"><c:out value="${translations['en'].condition_text}"/></textarea>
                        </div>

                        <button type="submit" class="button"><fmt:message key="admin.saveTranslation"/></button>
                    </form>
                </div>
            </div>
        </section>
    </section>
</main>
<%@ include file="../fragments/footer.jspf" %>
</body>
</html>
