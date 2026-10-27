package com.japanlife.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.japanlife.dto.UserCheck;
import com.japanlife.dto.UserTask;
import com.japanlife.dto.TaskEvent;

@Mapper
public interface TaskMapper {
    List<UserTask> findAllByMember(@Param("memberId") long memberId, @Param("language") String language);
    UserTask findByIdAndMember(@Param("id") long id, @Param("memberId") long memberId, @Param("language") String language);
    UserTask findByProcedureAndMember(@Param("procedureId") long procedureId, @Param("memberId") long memberId);
    List<UserCheck> findChecks(@Param("taskId") long taskId, @Param("language") String language);
    void insertTask(UserTask task);
    void insertCheck(UserCheck check);
    int updateCheck(@Param("checkId") long checkId, @Param("taskId") long taskId, @Param("checked") String checked);
    int updateStatus(@Param("id") long id, @Param("memberId") long memberId, @Param("status") String status);
    List<TaskEvent> findEvents(@Param("memberId") long memberId, @Param("from") String from, @Param("to") String to, @Param("language") String language);
    TaskEvent findEventByIdAndMember(@Param("id") long id, @Param("memberId") long memberId);
    void insertEvent(TaskEvent event);
    int updateEventCompleted(@Param("id") long id, @Param("memberId") long memberId, @Param("completed") String completed);
    int deleteEvent(@Param("id") long id, @Param("memberId") long memberId);
    int deleteEventsByTask(@Param("taskId") long taskId, @Param("memberId") long memberId);
    int deleteChecksByTask(@Param("taskId") long taskId);
    int deleteTask(@Param("id") long id, @Param("memberId") long memberId);
}
