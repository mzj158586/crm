package com.mgd.workbench.dao;

import com.mgd.workbench.domain.ActivityRemark;

import java.util.List;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/26
 * @Company:
 */
public interface ActivityRemarkDao {

    int getCountByAids(String [] aids);
    int deleteByAids(String [] aids);

    List selectActivityRemart(String id);

    int remarkRemove(String id);

    int saveRemark(ActivityRemark activityRemark);

    int updateRemark(ActivityRemark activityRemark);

}
