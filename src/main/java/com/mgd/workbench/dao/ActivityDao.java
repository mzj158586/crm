package com.mgd.workbench.dao;

import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.vo.ActivityVo;

import java.util.List;


/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/24
 * @Company:
 */
public interface ActivityDao {

    int savaActivity(Activity activity);
    List<Activity> selectPageList(ActivityVo activityVo);

    int getCountByAids(String [] aids);
    int deleteByAids(String [] aids);

    Activity selectById(String id);

    int updateActivity(Activity activity);
}
