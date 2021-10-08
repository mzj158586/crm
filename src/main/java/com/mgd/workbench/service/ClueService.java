package com.mgd.workbench.service;

import com.github.pagehelper.PageInfo;
import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.domain.Clue;
import com.mgd.workbench.domain.ClueRemark;
import com.mgd.workbench.vo.ClueVo;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/10/3
 * @Company:
 */
public interface ClueService {
    boolean savaClue(Clue clue);

    PageInfo<Clue> selectPageList(ClueVo clueVo);

    Clue selectById(String id);

    boolean updateClue(Clue clue);

    boolean deleteClue(String[] clueIds);

    Clue detailClue(String id);

    List<ClueRemark> showRemark(String clueId);

    List<Activity> selectRelation(String clueId);

    boolean disassociate(String id);

    List<Activity> getActivityByName(Map map);

    boolean addRelation(String[] ids, String clueId);
}
