package com.mgd.workbench.service;

import com.github.pagehelper.PageInfo;
import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.vo.ActivityVo;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/24
 * @Company:
 */
public interface ActivityService {

    public List getUserList();

    //插入数据
    public  int savaActivity(Activity activity);

    public PageInfo selectPageList(ActivityVo activityVo);

    public boolean delete(String []aids);


    Map<String,Object> selectById(String id);
    Map<String,Object> updateActivity(Activity activity);
}
