package com.japanlife.service;

import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;
import com.japanlife.dto.*;
import com.japanlife.mapper.ProcedureMapper;

@Service
public class ProcedureService {
    public static final int PAGE_SIZE = 6;
    private final ProcedureMapper mapper;
    public ProcedureService(ProcedureMapper mapper) { this.mapper = mapper; }

    public String cleanQuery(String query) {
        String cleaned = query == null ? "" : query.strip();
        if (cleaned.length() > 80) throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        return cleaned;
    }

    public String cleanSituation(String situation) {
        if (situation == null || situation.isBlank()) return "";
        if (!List.of("ABROAD", "DOMESTIC").contains(situation))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        return situation;
    }

    // LIKE 문법의 %, _도 사용자가 입력한 글자 그대로 검색합니다.
    private String pattern(String query) {
        return "%" + query.replace("!", "!!").replace("%", "!%").replace("_", "!_") + "%";
    }

    public int count(String query, String situation) { return count(query, situation, "", "ja"); }
    public int count(String query, String situation, String language) { return count(query, situation, "", language); }
    public int count(String query, String situation, String phase, String language) {
        return mapper.count(pattern(query), situation, cleanPhase(phase), language(language));
    }
    public List<Procedure> search(String query, String situation, int page) { return search(query, situation, "", page, "ja"); }
    public List<Procedure> search(String query, String situation, int page, String language) {
        return search(query, situation, "", page, language);
    }
    public List<Procedure> search(String query, String situation, String phase, int page, String language) {
        return mapper.search(pattern(query), situation, cleanPhase(phase), (page - 1) * PAGE_SIZE, page * PAGE_SIZE, language(language));
    }

    public String cleanPhase(String phase) {
        if (phase == null || phase.isBlank()) return "";
        if (!List.of("BEFORE_DEPARTURE", "AFTER_ARRIVAL", "DAILY_LIFE", "WORK_OR_SCHOOL", "MOVING_OR_UPDATE").contains(phase))
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        return phase;
    }
    public Procedure detail(long id) { return detail(id, "ja"); }
    public Procedure detail(long id, String language) {
        Procedure procedure = mapper.findPublished(id, language(language));
        if (procedure == null) throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        return procedure;
    }
    public List<RequiredDocument> documents(long id) { return documents(id, "ja"); }
    public List<RequiredDocument> documents(long id, String language) { return mapper.findDocuments(id, language(language)); }
    public List<ProcedureStep> steps(long id) { return steps(id, "ja"); }
    public List<ProcedureStep> steps(long id, String language) { return mapper.findSteps(id, language(language)); }
    public List<OfficialSource> sources(long id) { return sources(id, "ja"); }
    public List<OfficialSource> sources(long id, String language) { return mapper.findSources(id, language(language)); }
    public List<Office> offices(long id) { return offices(id, "ja"); }
    public List<Office> offices(long id, String language) { return mapper.findOffices(id, language(language)); }

    private String language(String language) {
        return "ko".equals(language) || "en".equals(language) ? language : "ja";
    }
}
