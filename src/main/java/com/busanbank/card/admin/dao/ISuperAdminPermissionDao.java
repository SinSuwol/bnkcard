package com.busanbank.card.admin.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.busanbank.card.admin.dto.PermissionDto;
import com.busanbank.card.card.dto.CardDto;

@Mapper
public interface ISuperAdminPermissionDao {

    CardDto selectCardTemp(@Param("cardNo") Long cardNo);

    int insertOrUpdateCard(CardDto dto);

    int updatePermissionApprove(@Param("cardNo") Long cardNo, @Param("sAdmin") String sAdmin);

    int updatePermissionReject(
        @Param("cardNo") Long cardNo,
        @Param("status") String status,
        @Param("reason") String reason,
        @Param("sAdmin") String sAdmin
    );

    List<PermissionDto> selectPermissionList();
}
