package com.mgd.interceptor;

import com.mgd.settings.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/23
 * @Company:
 */

/*拦截器*/
public class LoginInterceptor implements HandlerInterceptor {


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        System.out.println("拦截器执行了");
        User user = (User) request.getSession().getAttribute("user");
        if (user!=null){
            return true;
        }else {

            response.sendRedirect("/index.jsp");
            return false;

        }

    }



}
