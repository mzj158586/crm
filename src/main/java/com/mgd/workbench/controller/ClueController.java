package com.mgd.workbench.controller;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;
import com.mgd.settings.dao.UserDao;
import com.mgd.settings.domain.User;
import com.mgd.utils.DateTimeUtil;
import com.mgd.utils.UUIDUtil;
import com.mgd.workbench.domain.Activity;
import com.mgd.workbench.domain.ClueRemark;
import com.mgd.workbench.vo.ClueVo;
import com.mgd.workbench.domain.Clue;
import com.mgd.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/29
 * @Company:
 */

@Controller
@RequestMapping("/workbench/clue")
public class ClueController {

    @Autowired
    private UserDao userDao;

    @Autowired
    private ClueService clueService;

    @RequestMapping("/getUserList")
    @ResponseBody
    public List<User> getUserList(){

        List<User> userList = userDao.getUserList();

        return userList;
    }

    @RequestMapping("/savaClue")
    @ResponseBody
    public Map<String,Object> savaClue(Clue clue, HttpServletRequest request){

        System.out.println(11);
        String id = UUIDUtil.getUUID();
        clue.setId(id);
        User user = (User) request.getSession().getAttribute("user");
        clue.setCreateBy(user.getName());
        clue.setCreateTime(DateTimeUtil.getSysTime());
        boolean flag=clueService.savaClue(clue);
        Map<String,Object> map = new HashMap<>();
        map.put("flag",flag);
        return map;

    }


    @RequestMapping("/selectPageList")
    @ResponseBody
    public  PageInfo<Clue>  selectPageList(ClueVo clueVo){

        PageInfo<Clue> pageInfo=clueService.selectPageList(clueVo);

        return pageInfo;

    }

    @RequestMapping("/selectById")
    @ResponseBody
    public Map<String,Object> selectById(String id){
        Map<String,Object> map =new HashMap<>();
        List userList = userDao.getUserList();
        Clue clue=clueService.selectById(id);
        map.put("userList",userList);
        map.put("clue",clue);
        return map;

    }
    @RequestMapping("/updateClue")
    @ResponseBody
    public Map<String,Object> updateClue(Clue clue,HttpServletRequest request){
        Map<String,Object> map =new HashMap<>();
        User user = (User) request.getSession().getAttribute("user");
        clue.setEditBy(user.getName());
        clue.setEditTime(DateTimeUtil.getSysTime());
        boolean flag=clueService.updateClue(clue);
        map.put("flag",flag);
        return map;

    }

    @RequestMapping("/deleteClue")
    @ResponseBody
    public Map<String,Object> deleteClue(String ids){
        String[] clueIds = ids.split(",");
        boolean flag=clueService.deleteClue(clueIds);
        Map<String,Object> map=new HashMap<>();
        map.put("flag",flag);
        return map;
    }

    @RequestMapping("/detailClue")
    public String detailClue(String id ,HttpServletRequest request){

        Clue clue=clueService.detailClue(id);
        request.setAttribute("clue",clue);
        return "/workbench/clue/detail.jsp";
    }


    @RequestMapping("/showRemark")
    @ResponseBody
    public List<ClueRemark> showRemark(String clueId ){

        List<ClueRemark> list= clueService.showRemark(clueId);
        return list;

    }

    @RequestMapping("/selectRelation")
    @ResponseBody
    public List<Activity> selectRelation(String clueId){

        System.out.println(clueId);

        List<Activity> list=clueService.selectRelation(clueId);
        return list;
    }

    @RequestMapping("/disassociate")
    @ResponseBody
    public Map<String,Object> disassociate(String id){
        Map<String,Object> map = new HashMap<>();
        boolean flag = clueService.disassociate(id);
        map.put("flag",flag);
        return map;
    }

    @RequestMapping("/getActivityByName")
    @ResponseBody
    public List<Activity> getActivityByName(String clueId,String activityName){
        System.out.println(activityName);
        Map<String,Object> map = new HashMap<>();
        map.put("clueId",clueId);
        map.put("activityName",activityName);
        List<Activity> list=clueService.getActivityByName(map);

        return list;

    }

    @RequestMapping("/addRelation")
    @ResponseBody
    public Map<String,Object> addRelation(String activityId,String clueId){
        Map<String,Object> map = new HashMap<>();

        String[] ids = activityId.split(",");
        boolean flag = clueService.addRelation(ids,clueId);
        map.put("flag",flag);
        return map;

    }



}
