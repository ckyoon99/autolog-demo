<%--
 * Screen: 홈페이지 > 자산관리몰 > 장외채권매매
 * Author: 김신한
 * Desc: 장외채권매매 Ajax 데모용 mock 데이터 조회
 * WR: WR26208-DP1(2026-07-07) 신규 화면
 * WR: WR26213-DP1(2026-07-13) 장외채권매매 채권상세 테이블(TB_OTC_BOND_DTL) 조인 조회 반영
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="org.slf4j.Logger,org.slf4j.LoggerFactory" %>
<%
    response.setHeader("Cache-Control", "no-store");
    String mode = request.getParameter("mode");

    if ("search".equals(mode)) {
        /* WR26213-DP1: 검색 시 TB_OTC_BOND_DTL 조인 조회 — 테이블 미생성으로 ORA-00942 */
        Logger log = LoggerFactory.getLogger("DB-WealthManagement");
        String bondNm = request.getParameter("bondNm");
        if (bondNm == null) {
            bondNm = "";
        }
        String sql =
            "SELECT A.BOND_NM, A.MATURITY_DT, A.REMAIN_DD, A.YIELD_RT, " +
            "       B.CORP_YIELD_RT, B.GEN_YIELD_RT, B.CREDIT_GRD, B.RISK_GRD " +
            "  FROM TB_OTC_BOND_LIST A " +
            " INNER JOIN TB_OTC_BOND_DTL B ON A.BOND_ID = B.BOND_ID " +
            " WHERE A.USE_YN = 'Y' " +
            "   AND A.BOND_NM LIKE ? " +
            " ORDER BY A.MATURITY_DT";

        log.error("[DB ERROR] java.sql.SQLException: ORA-00942: table or view does not exist");
        log.error("[DB ERROR] Failed query: {}", sql);
        log.error("[DB ERROR] Missing object: TB_OTC_BOND_DTL");
        log.error("[DB ERROR] search keyword: {}", bondNm);

        response.setStatus(500);
%>
{"error":"DB_ERROR","code":"ORA-00942","message":"table or view does not exist - TB_OTC_BOND_DTL","sql":"SELECT A.BOND_NM ... FROM TB_OTC_BOND_LIST A INNER JOIN TB_OTC_BOND_DTL B ..."}
<%
        return;
    }
%>
{"result":"SUCCESS","investType":"안정형","items":[{"name":"국민주택1종채권22-01","maturity":"2027.01.31","period":"217일","yield":"2.700%","corpYield":"2.700%","genYield":"3.010%","credit":"","risk":"매우낮은위험"},{"name":"국민주택1종채권22-02","maturity":"2027.02.28","period":"245일","yield":"3.030%","corpYield":"3.040%","genYield":"3.410%","credit":"","risk":"매우낮은위험"},{"name":"삼성전자 회사채24-03","maturity":"2027.06.15","period":"352일","yield":"3.450%","corpYield":"3.460%","genYield":"3.820%","credit":"AA","risk":"낮은위험"}]}
