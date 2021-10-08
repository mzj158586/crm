package com.mgd.listen;

import com.mgd.workbench.service.DicService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.Map;
import java.util.Set;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/29
 * @Company:
 */
@WebListener
public class DicListen implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        ApplicationContext ac = new ClassPathXmlApplicationContext("applicatonContext.xml");
        DicService clueService = (DicService) ac.getBean("dicServiceImpl");
        Map<String, Object> map = clueService.getAll();
        Set<String> typeCodes = map.keySet();
        for (String key:typeCodes
             ) {

            servletContextEvent.getServletContext().setAttribute(key,map.get(key));

        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
