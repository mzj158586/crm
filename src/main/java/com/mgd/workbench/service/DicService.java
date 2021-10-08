package com.mgd.workbench.service;

import com.mgd.settings.domain.User;

import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/29
 * @Company:
 */
public interface DicService {

    List<User> getUserList();

    Map<String,Object>  getAll();

}
