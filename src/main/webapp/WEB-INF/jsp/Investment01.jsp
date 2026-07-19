<%--
 * Screen: 홈페이지 > 투자정보 > 기업분석
 * Author: 김신한
 * Desc: 기업분석 리포트목록 DB 조회 Ajax 데이터
 * WR: WR26211-DP1(2026-07-07) 신규 화면
 * WR: WR26216-DP1(2026-07-17) 기업분석 리포트 PDF 다운로드 경로 수정
--%>
<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="java.sql.*,com.autolog.util.JspDbUtil" %>
<%
    response.setHeader("Cache-Control", "no-store");

    String rptTypeCd = request.getParameter("rptTypeCd");
    if (rptTypeCd == null || rptTypeCd.trim().isEmpty()) {
        rptTypeCd = "CORP";
    }

    String stkNm = request.getParameter("stkNm");

    int topN = 10;
    try {
        topN = Integer.parseInt(request.getParameter("topN"));
    } catch (Exception ignore) {
        topN = 10;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = JspDbUtil.getConnection();

        /*
         * 기업분석 리포트 목록
         * TB_RSH_REPORT : 투자정보 리서치 리포트
         */
        String sql =
            "SELECT RPT_TITLE " +
            "     , STK_NM " +
            "     , INVST_OPNN " +
            "     , SUMMARY_TXT " +
            "     , ANALYST_NM " +
            "     , PUBL_DT " +
            "  FROM TB_RSH_REPORT " +
            " WHERE RPT_TYPE_CD = ? " +
            "   AND USE_YN = 'Y' " +
            "   AND (? IS NULL OR STK_NM LIKE '%' || ? || '%') " +
            " ORDER BY PUBL_DT DESC " +
            " FETCH FIRST ? ROWS ONLY";

        ps = conn.prepareStatement(sql);
        ps.setString(1, rptTypeCd);
        if (stkNm == null || stkNm.trim().isEmpty()) {
            ps.setNull(2, Types.VARCHAR);
            ps.setNull(3, Types.VARCHAR);
        } else {
            ps.setString(2, stkNm.trim());
            ps.setString(3, stkNm.trim());
        }
        ps.setInt(4, topN);

        rs = ps.executeQuery();

        StringBuilder items = new StringBuilder();
        boolean first = true;

        while (rs.next()) {
            String publDt = rs.getString("PUBL_DT");
            String dispDt = publDt.substring(0, 4) + "." + publDt.substring(4, 6) + "." + publDt.substring(6, 8);

            if (!first) {
                items.append(',');
            }
            items.append("{")
                .append("\"title\":\"").append(JspDbUtil.esc(rs.getString("RPT_TITLE"))).append("\",")
                .append("\"stock\":\"").append(JspDbUtil.esc(rs.getString("STK_NM"))).append("\",")
                .append("\"opinion\":\"").append(JspDbUtil.esc(rs.getString("INVST_OPNN"))).append("\",")
                .append("\"summary\":\"").append(JspDbUtil.esc(rs.getString("SUMMARY_TXT"))).append("\",")
                .append("\"analyst\":\"").append(JspDbUtil.esc(rs.getString("ANALYST_NM"))).append("\",")
                .append("\"date\":\"").append(dispDt).append("\"")
                .append("}");
            first = false;
        }

        out.print("{\"result\":\"SUCCESS\",\"items\":[" + items.toString() + "]}");

    } catch (SQLException e) {
        response.setStatus(500);
        out.print("{\"error\":\"DB_ERROR\",\"message\":\"" + JspDbUtil.esc(e.getMessage()) + "\"}");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
        if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
