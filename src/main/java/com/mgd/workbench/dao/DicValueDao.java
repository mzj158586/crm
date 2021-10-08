package com.mgd.workbench.dao;

import com.mgd.workbench.domain.DicValue;

import java.util.List;

/**
 * @Description:
 * @Author: 梅广东
 * @CreateTime: 2021/9/29
 * @Company:
 */
public interface DicValueDao {
    List<DicValue> getValueList(String typeCode);

}
