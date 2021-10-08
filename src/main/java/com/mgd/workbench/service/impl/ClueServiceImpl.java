package com.mgd.workbench.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mgd.utils.UUIDUtil;
import com.mgd.workbench.dao.ActivityDao;
import com.mgd.workbench.dao.ClueActivityRelationDao;
import com.mgd.workbench.dao.ClueDao;
import com.mgd.workbench.dao.ClueRemarkDao;
import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.domain.Clue;
import com.mgd.workbench.domain.ClueActivityRelation;
import com.mgd.workbench.domain.ClueRemark;
import com.mgd.workbench.service.ClueService;
import com.mgd.workbench.vo.ClueVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/10/3
 * @Company:
 */
@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueDao clueDao;

    @Autowired
    private ClueRemarkDao clueRemarkDao;

    @Autowired
    private ActivityDao activityDao;

    @Autowired
    private ClueActivityRelationDao clueActivityRelationDao;

    @Override
    public boolean savaClue(Clue clue) {
        boolean flag=false;
        int num=clueDao.savaClue(clue);
        if (num!=0){
            flag=true;
        }
        return flag;
    }

    @Override
    public PageInfo<Clue> selectPageList(ClueVo clueVo) {

        PageHelper.startPage(clueVo.getPageNo(),clueVo.getPageSize());
        List<Clue> list=clueDao.selectPageList(clueVo);
        PageInfo<Clue> pageInfo=new PageInfo(list);
        return pageInfo;
    }

    @Override
    public Clue selectById(String id) {
        Clue clue=clueDao.selectById(id);
        return clue;
    }

    @Override
    public boolean updateClue(Clue clue) {

        boolean flag=false;
        int num=clueDao.updateClue(clue);
        if (num!=0){
            flag=true;

        }

        return flag;
    }

    @Override
    public boolean deleteClue(String[] clueIds) {
        int num=clueDao.deleteClue(clueIds);

        boolean flag=false;
        if (num!=0){
            flag=true;

        }
        return flag;

    }

    @Override
    public Clue detailClue(String id) {

        Clue clue=clueDao.detailClue(id);
        return clue;
    }

    @Override
    public List<ClueRemark> showRemark(String clueId) {

        List<ClueRemark> list=clueRemarkDao.showRemark(clueId);
        return list;
    }

    @Override
    public List<Activity> selectRelation(String clueId) {

        List<Activity>list=activityDao.selectRelation(clueId);
        return list;
    }

    @Override
    public boolean disassociate(String id) {
        boolean flag = false;
        int num = clueActivityRelationDao.disassociate(id);
        if (num != 0){
            flag = true;
        }
        return flag;
    }



    @Override
    public List<Activity> getActivityByName(Map map) {
        List<Activity> list = activityDao.getActivityByName(map);
        return list;
    }

    @Override
    public boolean addRelation(String [] ids, String clueId) {
        boolean flag=false;
        for (String activityId:ids
             ) {
            String id = UUIDUtil.getUUID();
            ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setId(id);
            clueActivityRelation.setActivityId(activityId);
            clueActivityRelation.setClueId(clueId);
            int num = clueActivityRelationDao.addRelation(clueActivityRelation);
            if (num !=0){
                flag = true;
            }
        }
        return flag;

    }


}
