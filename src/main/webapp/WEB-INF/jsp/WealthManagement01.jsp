<%@ page contentType="application/json;charset=UTF-8" language="java" trimDirectiveWhitespaces="true"
         import="java.sql.*,com.autolog.util.JspDbUtil" %>
<%
    response.setHeader("Cache-Control", "no-store");

    String custId = request.getParameter("custId");
    if (custId == null || custId.trim().isEmpty()) {
        custId = "C20260001";
    }

    String bondNm = request.getParameter("bondNm");
    String invstTypeCd = request.getParameter("invstTypeCd");
    if (invstTypeCd == null || invstTypeCd.trim().isEmpty()) {
        invstTypeCd = "05";
    }

    Connection conn = null;
    PreparedStatement psInvst = null;
    PreparedStatement psBond = null;
    ResultSet rsInvst = null;
    ResultSet rsBond = null;

    try {
        conn = JspDbUtil.getConnection();

        /* 투자성향 조회 */
        String invstSql =
            "SELECT INVST_TYPE_NM " +
            "  FROM TB_CUST_INVST_PROFILE " +
            " WHERE CUST_ID = ? " +
            "   AND USE_YN = 'Y'";

        psInvst = conn.prepareStatement(invstSql);
        psInvst.setString(1, custId);
        rsInvst = psInvst.executeQuery();

        String investType = "미등록";
        if (rsInvst.next()) {
            investType = rsInvst.getString("INVST_TYPE_NM");
        }
        rsInvst.close();
        psInvst.close();

        /*
         * 장외채권 매수 가능 종목
         * TB_OTC_BOND_LIST : 장외채권 판매목록
         */
        String bondSql =
            "SELECT BOND_NM " +
            "     , MTRT_DT " +
            "     , INVST_PRD_DAYS " +
            "     , BUY_YIELD " +
            "     , CORP_YIELD " +
            "     , GEN_YIELD " +
            "     , CREDIT_GRD " +
            "     , RISK_GRD_NM " +
            "  FROM TB_OTC_BOND_LIST " +
            " WHERE SALE_YN = 'Y' " +
            "   AND INVST_TYPE_CD <= ? " +
            "   AND (? IS NULL OR BOND_NM LIKE '%' || ? || '%') " +
            " ORDER BY MTRT_DT";

        psBond = conn.prepareStatement(bondSql);
        psBond.setString(1, invstTypeCd);
        if (bondNm == null || bondNm.trim().isEmpty()) {
            psBond.setNull(2, Types.VARCHAR);
            psBond.setNull(3, Types.VARCHAR);
        } else {
            psBond.setString(2, bondNm.trim());
            psBond.setString(3, bondNm.trim());
        }

        rsBond = psBond.executeQuery();

        StringBuilder items = new StringBuilder();
        boolean first = true;
        while (rsBond.next()) {
            if (!first) {
                items.append(',');
            }
            items.append("{")
                .append("\"name\":\"").append(JspDbUtil.esc(rsBond.getString("BOND_NM"))).append("\",")
                .append("\"maturity\":\"").append(JspDbUtil.esc(rsBond.getString("MTRT_DT"))).append("\",")
                .append("\"period\":\"").append(rsBond.getInt("INVST_PRD_DAYS")).append("일\",")
                .append("\"yield\":\"").append(JspDbUtil.esc(rsBond.getString("BUY_YIELD"))).append("\",")
                .append("\"corpYield\":\"").append(JspDbUtil.esc(rsBond.getString("CORP_YIELD"))).append("\",")
                .append("\"genYield\":\"").append(JspDbUtil.esc(rsBond.getString("GEN_YIELD"))).append("\",")
                .append("\"credit\":\"").append(JspDbUtil.esc(rsBond.getString("CREDIT_GRD"))).append("\",")
                .append("\"risk\":\"").append(JspDbUtil.esc(rsBond.getString("RISK_GRD_NM"))).append("\"")
                .append("}");
            first = false;
        }

        out.print("{\"result\":\"SUCCESS\",\"investType\":\"" + JspDbUtil.esc(investType) +
            "\",\"items\":[" + items.toString() + "]}");

    } catch (SQLException e) {
        response.setStatus(500);
        out.print("{\"error\":\"DB_ERROR\",\"message\":\"" + JspDbUtil.esc(e.getMessage()) + "\"}");
    } finally {
        if (rsInvst != null) try { rsInvst.close(); } catch (SQLException ignore) {}
        if (rsBond != null) try { rsBond.close(); } catch (SQLException ignore) {}
        if (psInvst != null) try { psInvst.close(); } catch (SQLException ignore) {}
        if (psBond != null) try { psBond.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>
