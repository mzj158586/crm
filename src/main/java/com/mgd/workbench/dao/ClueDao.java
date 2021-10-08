package com.mgd.workbench.dao;


import com.mgd.workbench.domain.Clue;
import com.mgd.workbench.vo.ClueVo;

import java.util.List;

public interface ClueDao {


    int savaClue(Clue clue);

    List<Clue> selectPageList(ClueVo clueVo);

    Clue selectById(String id);

    int updateClue(Clue clue);

    int deleteClue(String[] clueIds);

    Clue detailClue(String id);
}
