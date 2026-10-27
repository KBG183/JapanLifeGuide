package com.japanlife.mapper;

import java.sql.Date;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AdminContentMapper {
    List<Map<String, Object>> findProcedures();
    Map<String, Object> findProcedure(long id);
    List<Map<String, Object>> findProcedureTranslations(long procedureId);
    int countProcedureTranslation(@Param("procedureId") long procedureId, @Param("lang") String lang);
    int updateProcedureTranslation(@Param("procedureId") long procedureId, @Param("lang") String lang, @Param("title") String title, @Param("summary") String summary, @Param("eligibility") String eligibility, @Param("deadline") String deadline, @Param("method") String method, @Param("notice") String notice);
    int insertProcedureTranslation(@Param("procedureId") long procedureId, @Param("lang") String lang, @Param("title") String title, @Param("summary") String summary, @Param("eligibility") String eligibility, @Param("deadline") String deadline, @Param("method") String method, @Param("notice") String notice);
    int countPublishedProcedures();
    List<Map<String, Object>> findDocuments();
    Map<String, Object> findDocument(long id);
    List<Map<String, Object>> findDocumentTranslations(long documentId);
    int countDocumentTranslation(@Param("documentId") long documentId, @Param("lang") String lang);
    int updateDocumentTranslation(@Param("documentId") long documentId, @Param("lang") String lang, @Param("name") String name, @Param("conditionText") String conditionText);
    int insertDocumentTranslation(@Param("documentId") long documentId, @Param("lang") String lang, @Param("name") String name, @Param("conditionText") String conditionText);
    List<Map<String, Object>> findSteps();
    List<Map<String, Object>> findSources();
    List<Map<String, Object>> findOffices();
    int insertProcedure(@Param("regionId") long regionId, @Param("categoryId") long categoryId, @Param("title") String title, @Param("summary") String summary, @Param("eligibility") String eligibility, @Param("deadline") String deadline, @Param("method") String method, @Param("notice") String notice, @Param("situation") String situation, @Param("phase") String phase, @Param("published") String published, @Param("revision") int revision);
    int updateProcedure(@Param("id") long id, @Param("regionId") long regionId, @Param("categoryId") long categoryId, @Param("title") String title, @Param("summary") String summary, @Param("eligibility") String eligibility, @Param("deadline") String deadline, @Param("method") String method, @Param("notice") String notice, @Param("situation") String situation, @Param("phase") String phase, @Param("published") String published, @Param("revision") int revision);
    int togglePublished(long id);
    int insertDocument(@Param("procedureId") long procedureId, @Param("name") String name, @Param("requirement") String requirement, @Param("conditionText") String conditionText, @Param("displayOrder") int displayOrder);
    int updateDocument(@Param("id") long id, @Param("procedureId") long procedureId, @Param("name") String name, @Param("requirement") String requirement, @Param("conditionText") String conditionText, @Param("displayOrder") int displayOrder);
    int insertStep(@Param("procedureId") long procedureId, @Param("stepNo") int stepNo, @Param("title") String title, @Param("description") String description);
    int updateStep(@Param("id") long id, @Param("procedureId") long procedureId, @Param("stepNo") int stepNo, @Param("title") String title, @Param("description") String description);
    int insertSource(@Param("procedureId") long procedureId, @Param("title") String title, @Param("url") String url, @Param("checkedOn") Date checkedOn, @Param("updatedOn") Date updatedOn);
    int updateSource(@Param("id") long id, @Param("procedureId") long procedureId, @Param("title") String title, @Param("url") String url, @Param("checkedOn") Date checkedOn, @Param("updatedOn") Date updatedOn);
    int insertOffice(@Param("name") String name, @Param("address") String address, @Param("homepageUrl") String homepageUrl, @Param("note") String note);
    int updateOffice(@Param("id") long id, @Param("name") String name, @Param("address") String address, @Param("homepageUrl") String homepageUrl, @Param("note") String note);
}
