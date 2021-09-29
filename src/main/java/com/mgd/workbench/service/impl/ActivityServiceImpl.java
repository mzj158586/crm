package com.mgd.workbench.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mgd.settings.dao.UserDao;
import com.mgd.workbench.dao.ActivityDao;
import com.mgd.workbench.dao.ActivityRemarkDao;
import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.domain.ActivityRemark;
import com.mgd.workbench.service.ActivityService;
import com.mgd.workbench.vo.ActivityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/24
 * @Company:
 */

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private ActivityRemarkDao activityRemarkDao;

    @Autowired
    private ActivityDao activityDao;

    public List getUserList() {
        List userList = userDao.getUserList();
        return userList;
    }

    @Override
    public int savaActivity(Activity activity) {
        int num = activityDao.savaActivity(activity);
        return num;
    }

    @Override
    public PageInfo selectPageList(ActivityVo activityVo) {
        PageHelper.startPage(activityVo.getPageNo(),activityVo.getPageSize());
        List<Activity> activities = activityDao.selectPageList(activityVo);
        for (Activity a :activities
                ) {
            System.out.println(a);
        }
        PageInfo info = new PageInfo(activities);

        return info ;
    }

    @Override
    public boolean delete(String[] aids) {
        boolean flag=true;
        int countByAids = activityRemarkDao.getCountByAids(aids);
        int deleteByAids = activityRemarkDao.deleteByAids(aids);
        if (countByAids!=deleteByAids){
            flag=false;

        }
        int count = activityDao.getCountByAids(aids);
        int count1 = activityDao.deleteByAids(aids);

        if (count!=count1){
            flag=false;
        }
        return flag;
    }

    @Override
    public Map<String, Object> selectById(String id) {
        List userList = userDao.getUserList();
        Activity activity=activityDao.selectById(id);
        Map<String,Object> map =new HashMap<>();
        map.put("userList",userList);
        map.put("activity",activity);
        return map;
    }

    @Override
    public Map<String, Object> updateActivity(Activity activity) {
        int num=activityDao.updateActivity(activity);
        boolean flag=false;
        if (num!=0){
            flag=true;
        }
        Map<String,Object> map =new HashMap<>();
        map.put("flag",flag);

        return map;
    }

    public Activity detail(String id){

        Activity activity=activityDao.detail(id);

        return activity;
    }

    @Override
    public List selectActivityRemart(String id) {
        List list=activityRemarkDao.selectActivityRemart(id);
        return list;
    }

    @Override
    public boolean remarkRemove(String id) {

         boolean flag=false;
         int num=activityRemarkDao.remarkRemove(id);
         if (num!=0){
             flag=true;
         }
        return flag;
    }

    @Override
    public boolean saveRemark(ActivityRemark activityRemark) {
        boolean flag=false;
        int num=activityRemarkDao.saveRemark(activityRemark);

        if (num!=0){
            flag=true;
        }
        return flag;
    }

    @Override
    public boolean updateRemark(ActivityRemark activityRemark) {
        boolean flag=false;
        int num=activityRemarkDao.updateRemark(activityRemark);

        if (num!=0){
            flag=true;
        }
        return flag;
    }


}
