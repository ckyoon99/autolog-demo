<%--
 * Screen: 홈페이지 > 연금자산 > 연금펀드 검색
 * Author: 김신한
 * Desc: 연금펀드 수익률 Top3 Ajax 데모용 데이터 조회 (DB 에러 시뮬레이션)
 * WR: WR26209-DP1(2026-07-07) 신규 화면
 * WR: WR26214-DP1(2026-07-26) 연금펀드 검색 RISK_TYPE_NM 컬럼 조회 추가
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%
    response.setHeader("Cache-Control", "no-store");

    /* WR26214-DP1: RISK_TYPE_NM 컬럼 추가 조회 — 컬럼 미존재로 ORA-00904 */
    Logger log = LoggerFactory.getLogger("DB-Pension");
    String sql =
        "SELECT RANK_NO, FUND_NM, RETURN_RT, FUND_TYPE_NM, RISK_TYPE_NM " +
        "  FROM TB_PNSN_FUND_RANK " +
        " WHERE PERIOD_CD = ? " +
        "   AND RANK_TYPE_CD = ? " +
        " ORDER BY RANK_NO " +
        " FETCH FIRST ? ROWS ONLY";

    log.error("[DB ERROR] java.sql.SQLException: ORA-00904: \"RISK_TYPE_NM\": invalid identifier");
    log.error("[DB ERROR] Failed query: {}", sql);
    log.error("[DB ERROR] Missing column: TB_PNSN_FUND_RANK.RISK_TYPE_NM");

    response.setStatus(500);
%>
{"error":"DB_ERROR","code":"ORA-00904","message":"invalid identifier - RISK_TYPE_NM","sql":"SELECT RANK_NO, FUND_NM, RETURN_RT, FUND_TYPE_NM, RISK_TYPE_NM FROM TB_PNSN_FUND_RANK ..."}
