<%--
 * Screen: 홈페이지 > 트레이딩 > 환전내역조회
 * Author: 김신한
 * Desc: 환전내역조회 뷰페이지
 * WR: WR26210-DP1(2026-07-07) 신규 화면
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    request.setAttribute("pageTitle", "환전내역조회 | 신한투자증권");

    request.setAttribute("pageCss", "trading.css");

    request.setAttribute("wrapperClass", "wrapper tradingWrap");

    request.setAttribute("gnbActive", "gnb04");

%>

<%@ include file="include/shinhan-head.jsp" %>

<script src="/js/Trading.js"></script>

<%@ include file="include/shinhan-header.jsp" %>

<div class="contents">

    <h1 class="titDep1">환전내역조회</h1>

    <ul class="tabType">

        <li class="on"><a href="#">환전내역</a></li>

        <li><a href="#">시간외가환전내역</a></li>

    </ul>

    <fieldset class="boxInquiry bgForm vspace">

        <legend>환전내역조회 입력폼</legend>

        <ul class="inqInfo">

            <li>

                <div class="inqTit"><label for="acct-no">계좌번호</label></div>

                <div class="inqCon"><input id="acct-no" type="text" style="width:330px" value="083-12-510148 고객(FNA)" readonly="readonly"/></div>

            </li>

            <li>

                <div class="inqTit"><label for="inq_dateFrom">조회기간</label></div>

                <div class="inqCon">

                    <input type="text" id="inq_dateFrom" class="inpDate" style="width:130px" value="-"/> ~

                    <input type="text" id="inq_dateTo" class="inpDate" style="width:130px" value="-"/>

                </div>

            </li>

        </ul>

        <button type="button" class="btnL btnInq">조회</button>

    </fieldset>

    <h2 class="titDep2 vspace">환전내역 정보</h2>

    <table class="tblH tbl_fx" summary="환전내역 정보">

        <caption>환전내역 정보</caption>

        <thead>

        <tr>

            <th scope="col">환전일자</th><th scope="col">환전시간</th><th scope="col">적용환율</th>

            <th scope="col">매도통화</th><th scope="col">매도금액</th><th scope="col">매수통화</th><th scope="col">매수금액</th>

        </tr>

        </thead>

        <tbody id="fxListBody">

        <tr><td colspan="7" class="data-loading">데이터 조회중...</td></tr>

        </tbody>

    </table>

</div>

<%@ include file="include/shinhan-footer.jsp" %>

<script>$(function(){ Trading.init(); });</script>

