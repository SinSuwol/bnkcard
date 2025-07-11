package com.busanbank.card.admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.busanbank.card.admin.dao.ISuperAdminPermissionDao;
import com.busanbank.card.admin.dto.PermissionDto;
import com.busanbank.card.card.dto.CardDto;

@Service
public class SuperAdminPermissionService {

    @Autowired
    private ISuperAdminPermissionDao dao;

    // 카드 TEMP 조회
    public CardDto getCardTemp(Long cardNo) {
        return dao.selectCardTemp(cardNo);
    }

    // 카드 승인 처리
    public boolean approveCard(CardDto dto, String sAdmin) {
        int inserted = dao.insertOrUpdateCard(dto);
        int updated = dao.updatePermissionApprove(dto.getCardNo(), sAdmin);
        return inserted > 0 && updated > 0;
    }

    // 보류/불허 처리
    public boolean rejectCard(Long cardNo, String status, String reason, String sAdmin) {
        int updated = dao.updatePermissionReject(cardNo, status, reason, sAdmin);
        return updated > 0;
    }

    // 리스트 조회
    public List<PermissionDto> getPermissionList() {
        return dao.selectPermissionList();
    }
}
