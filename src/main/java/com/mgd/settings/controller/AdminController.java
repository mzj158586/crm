package com.mgd.settings.controller;

import com.mgd.settings.domain.User;
import com.mgd.exception.LoginException;
import com.mgd.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/20
 * @Company:
 */

@Controller
@RequestMapping("/setting/user")
public class AdminController {

    @Autowired
    private UserService userService;

    @RequestMapping("/login.do")
    @ResponseBody
    public Map<String, Object> selectUser(User user, HttpServletRequest request) throws LoginException {
        String ip = request.getRemoteAddr();
        user.setAllowIps(ip);

            Map<String,Object> map =new HashMap<>();
        try {
            user = userService.selectLogin(user.getLoginAct(),user.getLoginPwd(),user.getAllowIps());
            request.getSession().setAttribute("user",user);
            map.put("flag",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag",false);
            map.put("msg",e.getMessage());

        }


        return map;

    }

}
