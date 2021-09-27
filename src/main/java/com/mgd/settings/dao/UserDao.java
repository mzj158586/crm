package com.mgd.settings.dao;

import com.mgd.settings.domain.User;

import java.util.List;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/22
 * @Company:
 */
public interface UserDao {

    User selectLogin(User user);
    List getUserList();

}
