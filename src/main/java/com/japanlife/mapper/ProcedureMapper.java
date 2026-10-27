package com.japanlife.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.japanlife.dto.*;

@Mapper
public interface ProcedureMapper {
    default List<Procedure> search(String pattern, String situation, int offset, int endRow) {
        return search(pattern, situation, "", offset, endRow, "ja");
    }
    default int count(String pattern, String situation) { return count(pattern, situation, "", "ja"); }
    default int count(String pattern, String situation, String language) { return count(pattern, situation, "", language); }
    default Procedure findPublished(long id) { return findPublished(id, "ja"); }
    default List<RequiredDocument> findDocuments(long id) { return findDocuments(id, "ja"); }
    default List<ProcedureStep> findSteps(long id) { return findSteps(id, "ja"); }
    default List<OfficialSource> findSources(long id) { return findSources(id, "ja"); }
    default List<Office> findOffices(long id) { return findOffices(id, "ja"); }

    List<Procedure> search(@Param("pattern") String pattern, @Param("situation") String situation,
                          @Param("phase") String phase, @Param("offset") int offset, @Param("endRow") int endRow, @Param("language") String language);
    int count(@Param("pattern") String pattern, @Param("situation") String situation, @Param("phase") String phase, @Param("language") String language);
    Procedure findPublished(@Param("id") long id, @Param("language") String language);
    List<RequiredDocument> findDocuments(@Param("id") long id, @Param("language") String language);
    List<ProcedureStep> findSteps(@Param("id") long id, @Param("language") String language);
    List<OfficialSource> findSources(@Param("id") long id, @Param("language") String language);
    List<Office> findOffices(@Param("id") long id, @Param("language") String language);
}
