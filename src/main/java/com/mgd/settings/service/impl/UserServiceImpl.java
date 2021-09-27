package com.mgd.settings.service.impl;

import com.mgd.settings.dao.UserDao;
import com.mgd.settings.domain.User;
import com.mgd.exception.LoginException;
import com.mgd.settings.service.UserService;
import com.mgd.utils.DateTimeUtil;
import com.mgd.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/22
 * @Company:
 */
@Service
public class UserServiceImpl implements UserService  {

    @Autowired
    private UserDao userDao;

    @Override
    public User selectLogin(String loginAct, String loginPwd, String ip) throws LoginException {
        String sysTime = DateTimeUtil.getSysTime();
        User user =new User();
        loginPwd = MD5Util.getMD5(loginPwd);
        user.setLoginAct(loginAct);
        user.setLoginPwd(loginPwd);
        user = userDao.selectLogin(user);
        if (user==null){

           throw new LoginException("用户不存在");
        }
        if (sysTime.compareTo(user.getCreateTime())<0){

            throw new LoginException("时间到期");

        }
        if ("0".equals(user.getLockState())){

            throw new LoginException("用户被锁定");
        }
        if (!(user.getAllowIps().contains(ip))){

            throw  new LoginException("ip不符合");
        }
        return user;
    }
}
