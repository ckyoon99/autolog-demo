<%--
 * Screen: 홈페이지 > 트레이딩 > 환전내역조회
 * Author: 김신한
 * Desc: 환전내역조회 DB 조회 Ajax 데이터
 * WR: WR26210-DP1(2026-07-07) 신규 화면
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="java.sql.*,com.autolog.util.JspDbUtil" %>
<%
    response.setHeader("Cache-Control", "no-store");

    String acctNo = request.getParameter("acctNo");
    if (acctNo == null || acctNo.trim().isEmpty()) {
        acctNo = "08312510148";
    } else {
        acctNo = acctNo.replace("-", "");
    }

    String dateFrom = request.getParameter("dateFrom");
    if (dateFrom == null || dateFrom.trim().isEmpty()) {
        dateFrom = "20260328";
    } else {
        dateFrom = dateFrom.replace(".", "");
    }

    String dateTo = request.getParameter("dateTo");
    if (dateTo == null || dateTo.trim().isEmpty()) {
        dateTo = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    } else {
        dateTo = dateTo.replace(".", "");
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = JspDbUtil.getConnection();

        /*
         * 환전내역 조회
         * TB_FX_TRADE_HIST : 계좌별 환전 거래내역
         */
        String sql =
            "SELECT FX_DT " +
            "     , FX_TM " +
            "     , APLY_EXRT " +
            "     , SEL_CURR_CD " +
            "     , SEL_AMT " +
            "     , BUY_CURR_CD " +
            "     , BUY_AMT " +
            "  FROM TB_FX_TRADE_HIST " +
            " WHERE ACCT_NO = ? " +
            "   AND FX_DT BETWEEN ? AND ? " +
            " ORDER BY FX_DT DESC, FX_TM DESC";

        ps = conn.prepareStatement(sql);
        ps.setString(1, acctNo);
        ps.setString(2, dateFrom);
        ps.setString(3, dateTo);

        rs = ps.executeQuery();

        StringBuilder items = new StringBuilder();
        boolean first = true;

        while (rs.next()) {
            String fxDt = rs.getString("FX_DT");
            String dispDt = fxDt.substring(0, 4) + "." + fxDt.substring(4, 6) + "." + fxDt.substring(6, 8);

            if (!first) {
                items.append(',');
            }
            items.append("{")
                .append("\"date\":\"").append(dispDt).append("\",")
                .append("\"time\":\"").append(JspDbUtil.esc(rs.getString("FX_TM"))).append("\",")
                .append("\"rate\":\"").append(JspDbUtil.esc(rs.getString("APLY_EXRT"))).append("\",")
                .append("\"sellCurr\":\"").append(JspDbUtil.esc(rs.getString("SEL_CURR_CD"))).append("\",")
                .append("\"sellAmt\":\"").append(JspDbUtil.esc(rs.getString("SEL_AMT"))).append("\",")
                .append("\"buyCurr\":\"").append(JspDbUtil.esc(rs.getString("BUY_CURR_CD"))).append("\",")
                .append("\"buyAmt\":\"").append(JspDbUtil.esc(rs.getString("BUY_AMT"))).append("\"")
                .append("}");
            first = false;
        }

        String dispFrom = dateFrom.substring(0, 4) + "." + dateFrom.substring(4, 6) + "." + dateFrom.substring(6, 8);
        String dispTo = dateTo.substring(0, 4) + "." + dateTo.substring(4, 6) + "." + dateTo.substring(6, 8);
        String dispAcct = acctNo.substring(0, 3) + "-" + acctNo.substring(3, 5) + "-" + acctNo.substring(5);

        out.print("{\"result\":\"SUCCESS\",\"acctNo\":\"" + dispAcct +
            "\",\"dateFrom\":\"" + dispFrom +
            "\",\"dateTo\":\"" + dispTo +
            "\",\"items\":[" + items.toString() + "]}");

    } catch (SQLException e) {
        response.setStatus(500);
        out.print("{\"error\":\"DB_ERROR\",\"message\":\"" + JspDbUtil.esc(e.getMessage()) + "\"}");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
