package com.mgd.workbench.dao;


import com.mgd.workbench.domain.ClueActivityRelation;

public interface ClueActivityRelationDao {


    int disassociate(String id);

    int addRelation(ClueActivityRelation clueActivityRelation);
}
