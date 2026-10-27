package com.japanlife.service;

import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.URI;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;
import com.japanlife.mapper.AdminContentMapper;

@Service
public class AdminContentService {
    private final AdminContentMapper mapper;
    public AdminContentService(AdminContentMapper mapper) { this.mapper = mapper; }

    public List<Map<String,Object>> procedures() {
        return mapper.findProcedures();
    }

    public Map<String, Object> procedure(long id) {
        Map<String, Object> p = mapper.findProcedure(id);
        if (p == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return p;
    }

    public Map<String, Map<String, Object>> procedureTranslations(long procedureId) {
        List<Map<String, Object>> rows = mapper.findProcedureTranslations(procedureId);
        Map<String, Map<String, Object>> result = new HashMap<>();
        for (Map<String, Object> row : rows) {
            String code = (String) (row.get("LANGUAGE_CODE") != null ? row.get("LANGUAGE_CODE") : row.get("language_code"));
            result.put(code, row);
        }
        return result;
    }

    @Transactional
    public void saveProcedureTranslation(long procedureId, String lang, String title, String summary, String eligibility, String deadline, String method, String notice) {
        if (!List.of("ko", "en").contains(lang)) throw new IllegalArgumentException("Invalid language code");
        title = required(title, "title", 200);
        summary = required(summary, "summary", 600);
        eligibility = required(eligibility, "eligibility", 1000);
        deadline = optional(deadline, "deadline", 500);
        method = optional(method, "method", 500);
        notice = optional(notice, "notice", 1000);

        int count = mapper.countProcedureTranslation(procedureId, lang);
        if (count > 0) {
            mapper.updateProcedureTranslation(procedureId, lang, title, summary, eligibility, deadline, method, notice);
        } else {
            mapper.insertProcedureTranslation(procedureId, lang, title, summary, eligibility, deadline, method, notice);
        }
    }

    public int publishedProcedureCount() { return mapper.countPublishedProcedures(); }

    public List<Map<String,Object>> documents() {
        return mapper.findDocuments();
    }

    public Map<String, Object> document(long id) {
        Map<String, Object> doc = mapper.findDocument(id);
        if (doc == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return doc;
    }

    public Map<String, Map<String, Object>> documentTranslations(long documentId) {
        List<Map<String, Object>> rows = mapper.findDocumentTranslations(documentId);
        Map<String, Map<String, Object>> result = new HashMap<>();
        for (Map<String, Object> row : rows) {
            String code = (String) (row.get("LANGUAGE_CODE") != null ? row.get("LANGUAGE_CODE") : row.get("language_code"));
            result.put(code, row);
        }
        return result;
    }

    @Transactional
    public void saveDocumentTranslation(long documentId, String lang, String name, String conditionText) {
        if (!List.of("ko", "en").contains(lang)) throw new IllegalArgumentException("Invalid language code");
        name = required(name, "name", 200);
        conditionText = optional(conditionText, "conditionText", 1000);

        int count = mapper.countDocumentTranslation(documentId, lang);
        if (count > 0) {
            mapper.updateDocumentTranslation(documentId, lang, name, conditionText);
        } else {
            mapper.insertDocumentTranslation(documentId, lang, name, conditionText);
        }
    }

    public List<Map<String,Object>> steps() { return mapper.findSteps(); }
    public List<Map<String,Object>> sources() { return mapper.findSources(); }
    public List<Map<String,Object>> offices() { return mapper.findOffices(); }

    private String required(String value, String name, int max) {
        String clean = value == null ? "" : value.strip();
        if (clean.isBlank() || clean.length() > max) throw new IllegalArgumentException(name);
        return clean;
    }
    private long number(String value, String name) { try { long n=Long.parseLong(value); if(n<1) throw new NumberFormatException(); return n; } catch(Exception e) { throw new IllegalArgumentException(name); } }
    private int integer(String value, String name) { try { int n=Integer.parseInt(value); if(n<1) throw new NumberFormatException(); return n; } catch(Exception e) { throw new IllegalArgumentException(name); } }
    private Date date(String value, String name, boolean nullable) { if(nullable && (value==null || value.isBlank())) return null; try{return Date.valueOf(value);}catch(Exception e){throw new IllegalArgumentException(name);} }
    private String optional(String value, String name, int max) { if(value==null || value.isBlank()) return null; String clean=value.strip(); if(clean.length()>max)throw new IllegalArgumentException(name); return clean; }
    private String officialUrl(String value, String name) {
        try {
            URI uri = URI.create(required(value, name, 1000));
            String host = uri.getHost();
            if (!"https".equalsIgnoreCase(uri.getScheme()) || host == null
                    || !(host.endsWith(".go.jp") || host.endsWith(".lg.jp") || host.endsWith(".tokyo.jp")
                    || host.equals("kojinbango-card.go.jp") || host.endsWith(".kojinbango-card.go.jp"))) {
                throw new IllegalArgumentException(name);
            }
            return uri.toString();
        } catch (IllegalArgumentException e) { throw new IllegalArgumentException(name); }
    }

    @Transactional
    public void saveProcedure(String id, String regionId, String categoryId, String title, String summary, String eligibility, String deadline, String method, String notice, String situation, String phase, String published, String revision) {
        long region=number(regionId,"region"), category=number(categoryId,"category");
        title=required(title,"title",200); summary=required(summary,"summary",600); eligibility=required(eligibility,"eligibility",1000);
        deadline=optional(deadline,"deadline",500); method=optional(method,"method",500); notice=optional(notice,"notice",1000);
        if(!List.of("ABROAD","DOMESTIC").contains(situation) || !List.of("BEFORE_DEPARTURE","AFTER_ARRIVAL","DAILY_LIFE","WORK_OR_SCHOOL","MOVING_OR_UPDATE").contains(phase) || !List.of("Y","N").contains(published)) throw new IllegalArgumentException("procedure values");
        int rev=integer(revision,"revision");
        if(id==null || id.isBlank()) mapper.insertProcedure(region,category,title,summary,eligibility,deadline,method,notice,situation,phase,published,rev);
        else requireUpdated(mapper.updateProcedure(number(id,"id"),region,category,title,summary,eligibility,deadline,method,notice,situation,phase,published,rev));
    }
    public void togglePublished(String id) { requireUpdated(mapper.togglePublished(number(id,"id"))); }
    public void saveDocument(String id,String procedureId,String name,String requirement,String condition,String order){ name=required(name,"name",200); condition=optional(condition,"condition",1000); if(!List.of("REQUIRED","CONDITIONAL").contains(requirement)||("CONDITIONAL".equals(requirement)&&condition==null))throw new IllegalArgumentException("document values"); if(id==null||id.isBlank())mapper.insertDocument(number(procedureId,"procedure"),name,requirement,condition,integer(order,"order"));else requireUpdated(mapper.updateDocument(number(id,"id"),number(procedureId,"procedure"),name,requirement,condition,integer(order,"order"))); }
    public void saveStep(String id,String procedureId,String no,String title,String description){title=required(title,"title",200);description=required(description,"description",1000);if(id==null||id.isBlank())mapper.insertStep(number(procedureId,"procedure"),integer(no,"step"),title,description);else requireUpdated(mapper.updateStep(number(id,"id"),number(procedureId,"procedure"),integer(no,"step"),title,description));}
    public void saveSource(String id,String procedureId,String title,String url,String checked,String updated){title=required(title,"title",200);url=officialUrl(url,"url");Date checkedDate=date(checked,"checked",false),updatedDate=date(updated,"updated",true);if(id==null||id.isBlank())mapper.insertSource(number(procedureId,"procedure"),title,url,checkedDate,updatedDate);else requireUpdated(mapper.updateSource(number(id,"id"),number(procedureId,"procedure"),title,url,checkedDate,updatedDate));}
    public void saveOffice(String id,String name,String address,String homepage,String note){name=required(name,"name",200);address=optional(address,"address",500);homepage=officialUrl(homepage,"homepage");note=optional(note,"note",1000);if(id==null||id.isBlank())mapper.insertOffice(name,address,homepage,note);else requireUpdated(mapper.updateOffice(number(id,"id"),name,address,homepage,note));}
    private void requireUpdated(int rows) { if (rows == 0) throw new ResponseStatusException(HttpStatus.NOT_FOUND); }
}
