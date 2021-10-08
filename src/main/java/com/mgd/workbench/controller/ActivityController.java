package com.mgd.workbench.controller;

import com.github.pagehelper.PageInfo;
import com.mgd.settings.domain.User;
import com.mgd.utils.DateTimeUtil;
import com.mgd.utils.UUIDUtil;
import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.domain.ActivityRemark;
import com.mgd.workbench.service.ActivityService;
import com.mgd.workbench.vo.ActivityVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/24
 * @Company:
 */
@Controller
@RequestMapping("/workbench/activity")
public class ActivityController {


    @Autowired
    private ActivityService activityService;



    @RequestMapping("/getUserList")
    @ResponseBody
    public List getUserList(){

        List userList = activityService.getUserList();
        return userList;

    }

    @RequestMapping("/sava")
    @ResponseBody
    public Map<String,Object>  savaActivity(Activity activity, HttpServletRequest request){

        String id = UUIDUtil.getUUID();
        String ctreateTime = DateTimeUtil.getSysTime();
        String ctreateBy = ((User) request.getSession().getAttribute("user")).getName();
        activity.setCreateTime(ctreateTime);
        activity.setCreateBy(ctreateBy);
        activity.setId(id);
        Map<String,Object> map =new HashMap<>();
        try {
            int num = activityService.savaActivity(activity);
            map.put("flag",true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("flag",false);
        }
        return map;
    }

    @RequestMapping("/selectPageList")
    @ResponseBody
    public PageInfo selectPageList(ActivityVo activityVo){

        PageInfo pageInfo = activityService.selectPageList(activityVo);


        return pageInfo;

    }

    @RequestMapping("/deleteActivity")
    @ResponseBody
    public Map<String,Object> deleteActivity(String ids){

        String []aids=ids.split(",");

        boolean flag = activityService.delete(aids);
        Map<String,Object> map=new HashMap<>();
        map.put("flag",flag);
        return map;
    }

    @RequestMapping("/selectById")
    @ResponseBody
    public Map<String,Object> selectById(String id){

        System.out.println(11);
        Map<String,Object> map=activityService.selectById(id);

        return map;

    }

    @RequestMapping("/updateActivity")
    @ResponseBody
    public Map<String,Object> updateActivity(Activity activity){

        Map<String,Object> map =activityService.updateActivity(activity);
        return map;

    }

    @RequestMapping("/detail")
    public String  detail(String id,HttpServletRequest request){

        Activity activity= activityService.detail(id);
        request.setAttribute("activity",activity);

        return "/workbench/activity/detail.jsp";

    }

    @RequestMapping("/selectActivityRemart")
    @ResponseBody
    public List selectActivityRemart(String id){
        System.out.println(11);
        List<ActivityRemark> list=activityService.selectActivityRemart(id);

        for (ActivityRemark activityRemark :list
                ) {
            System.out.println(activityRemark);
        }


        return list;
    }


    @RequestMapping("/remarkRemove")
    @ResponseBody
    public Map<String,Object> remarkRemove(String id ){
        Map<String,Object> map =new HashMap<>();

        boolean flag=activityService.remarkRemove(id);
        map.put("flag",flag);
        System.out.println(11);
        System.out.println(flag);
        return map;

    }
    @RequestMapping("/saveRemark")
    @ResponseBody
    public Map<String,Object> saveRemark(ActivityRemark activityRemark,HttpServletRequest request){
        String id = UUIDUtil.getUUID();
        activityRemark.setId(id);
        String sysTime = DateTimeUtil.getSysTime();
        activityRemark.setCreateTime(sysTime);
        Map<String,Object> map= new HashMap<>();
        User user = (User) request.getSession().getAttribute("user");
        String createBy = user.getName();
        activityRemark.setCreateBy(createBy);
        activityRemark.setEditFlag("0");
        boolean flag=activityService.saveRemark(activityRemark);
        map.put("flag",flag);
        map.put("activityRemark",activityRemark);
        return map;

    }

    @RequestMapping("/updateRemark")
    @ResponseBody
    public  Map<String,Object> updateRemark(ActivityRemark activityRemark,HttpServletRequest request){

        User user = (User) request.getSession().getAttribute("user");
        activityRemark.setEditBy(user.getName());
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        activityRemark.setEditFlag("1");
         boolean flag=activityService.updateRemark(activityRemark);
        Map<String,Object> map =new HashMap<>();
        map.put("flag",flag);
        System.out.println(flag);
        map.put("activityRemark",activityRemark);
        return map;

    }


}
