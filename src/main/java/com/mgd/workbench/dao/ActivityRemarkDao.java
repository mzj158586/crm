package com.mgd.workbench.dao;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/26
 * @Company:
 */
public interface ActivityRemarkDao {

    int getCountByAids(String [] aids);
    int deleteByAids(String [] aids);
}
