package com.mgd.workbench.dao;

import com.mgd.workbench.domain.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {

    List<ClueRemark> showRemark(String clueId);
}
