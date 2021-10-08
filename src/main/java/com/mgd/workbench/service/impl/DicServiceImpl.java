package com.mgd.workbench.service.impl;

import com.mgd.settings.dao.UserDao;
import com.mgd.settings.domain.User;
import com.mgd.workbench.dao.DicTypeDao;
import com.mgd.workbench.dao.DicValueDao;
import com.mgd.workbench.domain.DicType;
import com.mgd.workbench.domain.DicValue;
import com.mgd.workbench.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/29
 * @Company:
 */

@Service
public class DicServiceImpl implements DicService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private DicTypeDao dicTypeDao;
    @Autowired
    private DicValueDao dicValueDao;

    @Override
    public List<User> getUserList() {
        List<User> userList = userDao.getUserList();
        return userList;
    }

    @Override
    public Map<String, Object> getAll() {

        Map<String,Object> map = new HashMap<>();
        List<DicType> typeList = dicTypeDao.getTypeList();

        for (DicType dicType: typeList
             ) {
            List<DicValue> valueList = dicValueDao.getValueList(dicType.getCode());
            map.put(dicType.getCode(),valueList);
        }


        return map;
    }
}
