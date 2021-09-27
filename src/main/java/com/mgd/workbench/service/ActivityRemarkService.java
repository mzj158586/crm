package com.mgd.workbench.service;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/26
 * @Company:
 */
public interface ActivityRemarkService {


    int getCountByAids(String [] aids);
    int deleteByAids(String [] aids);


}
