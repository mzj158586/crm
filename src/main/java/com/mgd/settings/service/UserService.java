package com.mgd.settings.service;

import com.mgd.settings.domain.User;
import com.mgd.exception.LoginException;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/20
 * @Company:
 */
public interface UserService {
    User selectLogin(String loginAct, String loginPwd, String ip) throws LoginException;
}
