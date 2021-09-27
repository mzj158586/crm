package com.mgd.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;

/**
 * @Description:登录异常
 * @Author: 梅广东
 * @CreateTime: 2021/9/23
 * @Company:
 */

public class LoginException extends Exception {
    public LoginException() {
        super();
    }

    public LoginException(String message) {
        super(message);
    }
}
