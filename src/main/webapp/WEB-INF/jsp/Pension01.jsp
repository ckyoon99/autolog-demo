<%--
 * Screen: 홈페이지 > 연금자산 > 연금펀드 검색
 * Author: 김신한
 * Desc: 연금펀드 수익률 Top3 DB 조회 Ajax 데이터
 * WR: WR26209-DP1(2026-07-07) 신규 화면
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="java.sql.*,com.autolog.util.JspDbUtil" %>
<%
    response.setHeader("Cache-Control", "no-store");

    String periodCd = request.getParameter("periodCd");
    if (periodCd == null || periodCd.trim().isEmpty()) {
        periodCd = "3M";
    }

    String rankTypeCd = request.getParameter("rankTypeCd");
    if (rankTypeCd == null || rankTypeCd.trim().isEmpty()) {
        rankTypeCd = "RETURN";
    }

    int topN = 3;
    try {
        topN = Integer.parseInt(request.getParameter("topN"));
    } catch (Exception ignore) {
        topN = 3;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = JspDbUtil.getConnection();

        /*
         * 연금펀드 수익률 Best N
         * TB_PNSN_FUND_RANK : 연금펀드 랭킹(기간/유형별)
         */
        String sql =
            "SELECT RNK " +
            "     , FUND_NM " +
            "     , RETURN_RT " +
            "     , FUND_TYPE_NM " +
            "     , RISK_NM " +
            "  FROM ( " +
            "        SELECT ROWNUM AS RNK, T.* " +
            "          FROM ( " +
            "                SELECT FUND_NM " +
            "                     , RETURN_RT " +
            "                     , FUND_TYPE_NM " +
            "                     , RISK_NM " +
            "                  FROM TB_PNSN_FUND_RANK " +
            "                 WHERE PERIOD_CD = ? " +
            "                   AND RANK_TYPE_CD = ? " +
            "                   AND USE_YN = 'Y' " +
            "                 ORDER BY RETURN_RT DESC " +
            "               ) T " +
            "         WHERE ROWNUM <= ? " +
            "       )";

        ps = conn.prepareStatement(sql);
        ps.setString(1, periodCd);
        ps.setString(2, rankTypeCd);
        ps.setInt(3, topN);

        rs = ps.executeQuery();

        String periodLabel = "3M".equals(periodCd) ? "3개월" : periodCd;
        StringBuilder items = new StringBuilder();
        boolean first = true;

        while (rs.next()) {
            if (!first) {
                items.append(',');
            }
            items.append("{")
                .append("\"rank\":").append(rs.getInt("RNK")).append(",")
                .append("\"name\":\"").append(JspDbUtil.esc(rs.getString("FUND_NM"))).append("\",")
                .append("\"returnRate\":\"").append(JspDbUtil.esc(rs.getString("RETURN_RT"))).append("\",")
                .append("\"types\":[\"").append(JspDbUtil.esc(rs.getString("FUND_TYPE_NM"))).append("\",")
                .append("\"").append(JspDbUtil.esc(rs.getString("RISK_NM"))).append("\"]")
                .append("}");
            first = false;
        }

        out.print("{\"result\":\"SUCCESS\",\"period\":\"" + JspDbUtil.esc(periodLabel) +
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
