<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<fmt:setLocale value="${currentLanguage}"/>
<fmt:setBundle basename="messages/messages"/>
<c:set var="adminSection" value="procedures"/>
<!DOCTYPE html>
<html lang="${currentLanguage}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title><fmt:message key="admin.translations"/> - <c:out value="${procedure.title}"/> | JAPAN LIFE GUIDE</title>
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
                <p class="eyebrow"><fmt:message key="admin.contentGroup"/> &gt; <fmt:message key="admin.procedures"/></p>
                <h1><fmt:message key="admin.translations"/>: <c:out value="${procedure.title}"/> (#${procedure.id})</h1>
            </div>
            <div>
                <a href="<c:url value='/admin/procedures'/>" class="button-outline"><fmt:message key="admin.backToList"/></a>
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
                    <dt>Title (タイトル):</dt>
                    <dd><c:out value="${procedure.title}"/></dd>
                    <dt>Summary (概要):</dt>
                    <dd><c:out value="${procedure.summary}"/></dd>
                    <dt>Eligibility (対象者):</dt>
                    <dd><c:out value="${procedure.eligibility}"/></dd>
                    <dt>Deadline (期限):</dt>
                    <dd><c:out value="${procedure.deadline_text}" default="-"/></dd>
                    <dt>Method (方法):</dt>
                    <dd><c:out value="${procedure.method_text}" default="-"/></dd>
                    <dt>Notice (注意事項):</dt>
                    <dd><c:out value="${procedure.notice}" default="-"/></dd>
                </dl>
            </div>

            <div class="translation-grid">
                <!-- Korean Translation Card -->
                <div class="translation-card">
                    <h3><fmt:message key="admin.translationKo"/></h3>
                    <form action="<c:url value='/admin/procedures/${procedure.id}/translations'/>" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="lang" value="ko">

                        <div class="field-group">
                            <label for="ko_title">Title (제목) *</label>
                            <input type="text" id="ko_title" name="title" required maxlength="200" value="<c:out value='${translations[\"ko\"].title}'/>">
                        </div>
                        <div class="field-group">
                            <label for="ko_summary">Summary (요약) *</label>
                            <textarea id="ko_summary" name="summary" required maxlength="600"><c:out value="${translations['ko'].summary}"/></textarea>
                        </div>
                        <div class="field-group">
                            <label for="ko_eligibility">Eligibility (대상자) *</label>
                            <textarea id="ko_eligibility" name="eligibility" required maxlength="1000"><c:out value="${translations['ko'].eligibility}"/></textarea>
                        </div>
                        <div class="field-group">
                            <label for="ko_deadline">Deadline (기한)</label>
                            <input type="text" id="ko_deadline" name="deadline" maxlength="500" value="<c:out value='${translations[\"ko\"].deadline_text}'/>">
                        </div>
                        <div class="field-group">
                            <label for="ko_method">Method (신고 방법)</label>
                            <input type="text" id="ko_method" name="method" maxlength="500" value="<c:out value='${translations[\"ko\"].method_text}'/>">
                        </div>
                        <div class="field-group">
                            <label for="ko_notice">Notice (주의사항)</label>
                            <textarea id="ko_notice" name="notice" maxlength="1000"><c:out value="${translations['ko'].notice}"/></textarea>
                        </div>

                        <button type="submit" class="button"><fmt:message key="admin.saveTranslation"/></button>
                    </form>
                </div>

                <!-- English Translation Card -->
                <div class="translation-card">
                    <h3><fmt:message key="admin.translationEn"/></h3>
                    <form action="<c:url value='/admin/procedures/${procedure.id}/translations'/>" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                        <input type="hidden" name="lang" value="en">

                        <div class="field-group">
                            <label for="en_title">Title *</label>
                            <input type="text" id="en_title" name="title" required maxlength="200" value="<c:out value='${translations[\"en\"].title}'/>">
                        </div>
                        <div class="field-group">
                            <label for="en_summary">Summary *</label>
                            <textarea id="en_summary" name="summary" required maxlength="600"><c:out value="${translations['en'].summary}"/></textarea>
                        </div>
                        <div class="field-group">
                            <label for="en_eligibility">Eligibility *</label>
                            <textarea id="en_eligibility" name="eligibility" required maxlength="1000"><c:out value="${translations['en'].eligibility}"/></textarea>
                        </div>
                        <div class="field-group">
                            <label for="en_deadline">Deadline</label>
                            <input type="text" id="en_deadline" name="deadline" maxlength="500" value="<c:out value='${translations[\"en\"].deadline_text}'/>">
                        </div>
                        <div class="field-group">
                            <label for="en_method">Method</label>
                            <input type="text" id="en_method" name="method" maxlength="500" value="<c:out value='${translations[\"en\"].method_text}'/>">
                        </div>
                        <div class="field-group">
                            <label for="en_notice">Notice</label>
                            <textarea id="en_notice" name="notice" maxlength="1000"><c:out value="${translations['en'].notice}"/></textarea>
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
