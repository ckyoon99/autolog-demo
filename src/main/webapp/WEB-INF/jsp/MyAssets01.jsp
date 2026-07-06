<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="java.sql.*,com.autolog.util.JspDbUtil" %>
<%
    response.setHeader("Cache-Control", "no-store");

    /* 요청 파라미터 */
    String custId = request.getParameter("custId");
    if (custId == null || custId.trim().isEmpty()) {
        custId = "C20260001";
    }

    String baseDt = request.getParameter("baseDt");
    if (baseDt == null || baseDt.trim().isEmpty()) {
        baseDt = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = JspDbUtil.getConnection();

        /*
         * 전계좌현황 — 고객별 계좌 자산 합계 조회
         * TB_CUST_ACCT      : 고객계좌
         * TB_ACCT_ASSET_SUM : 계좌별 자산집계(일별)
         */
        String sql =
            "SELECT A.ACCT_NO " +
            "     , A.ACCT_NICK " +
            "     , A.ACCT_TYPE_NM " +
            "     , A.MAIN_ACCT_YN " +
            "     , S.TOT_ASSET_AMT " +
            "     , S.WTHDW_PSBL_AMT " +
            "     , S.FIN_PROD_AMT " +
            "     , S.STK_EVAL_AMT " +
            "     , S.DEPO_AMT " +
            "  FROM TB_CUST_ACCT A " +
            " INNER JOIN TB_ACCT_ASSET_SUM S " +
            "    ON A.ACCT_NO = S.ACCT_NO " +
            "   AND S.BASE_DT = ? " +
            " WHERE A.CUST_ID = ? " +
            "   AND A.USE_YN = 'Y' " +
            " ORDER BY A.MAIN_ACCT_YN DESC, A.ACCT_NO";

        ps = conn.prepareStatement(sql);
        ps.setString(1, baseDt);
        ps.setString(2, custId);

        rs = ps.executeQuery();

        StringBuilder accounts = new StringBuilder();
        String primaryJson = null;
        long totalAsset = 0L;
        boolean first = true;

        while (rs.next()) {
            long acctTotal = rs.getLong("TOT_ASSET_AMT");
            totalAsset += acctTotal;

            String acctJson =
                "{\"no\":\"" + JspDbUtil.esc(rs.getString("ACCT_NO")) + "\"," +
                "\"name\":\"" + JspDbUtil.esc(rs.getString("ACCT_NICK")) + "\"," +
                "\"type\":\"" + JspDbUtil.esc(rs.getString("ACCT_TYPE_NM")) + "\"," +
                "\"total\":" + acctTotal + "," +
                "\"withdraw\":" + rs.getLong("WTHDW_PSBL_AMT") + "," +
                "\"finProd\":" + rs.getLong("FIN_PROD_AMT") + "," +
                "\"stock\":" + rs.getLong("STK_EVAL_AMT") + "," +
                "\"deposit\":" + rs.getLong("DEPO_AMT") + "}";

            if ("Y".equals(rs.getString("MAIN_ACCT_YN")) && primaryJson == null) {
                primaryJson = acctJson;
            } else {
                if (!first && accounts.length() > 0) {
                    accounts.append(',');
                }
                accounts.append(acctJson);
                first = false;
            }
        }

        if (primaryJson == null) {
            response.setStatus(404);
            out.print("{\"error\":\"NOT_FOUND\",\"message\":\"custId=" + JspDbUtil.esc(custId) + " data not found\"}");
            return;
        }

        String currentDate = baseDt.substring(0, 4) + "." + baseDt.substring(4, 6) + "." + baseDt.substring(6, 8);
        out.print("{\"result\":\"SUCCESS\"," +
            "\"totalAsset\":" + totalAsset + "," +
            "\"currentDate\":\"" + currentDate + "\"," +
            "\"primaryAcct\":" + primaryJson + "," +
            "\"accounts\":[" + accounts.toString() + "]}");

    } catch (SQLException e) {
        response.setStatus(500);
        out.print("{\"error\":\"DB_ERROR\",\"message\":\"" + JspDbUtil.esc(e.getMessage()) + "\"}");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
