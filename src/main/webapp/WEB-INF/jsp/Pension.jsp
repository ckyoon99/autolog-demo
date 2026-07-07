<%--
 * Screen: 홈페이지 > 연금자산 > 연금펀드 검색
 * Author: 김신한
 * Desc: 연금펀드 검색 뷰페이지
 * WR: WR26209-DP1(2026-07-07) 신규 화면
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    request.setAttribute("pageTitle", "연금펀드 검색 | 신한투자증권");

    request.setAttribute("pageCss", "pension.css");

    request.setAttribute("wrapperClass", "wrapper");

    request.setAttribute("gnbActive", "gnb03");

%>

<%@ include file="include/shinhan-head.jsp" %>

<link rel="stylesheet" href="/css/pension-page.css"/>

<script src="/js/Pension.js"></script>

<%@ include file="include/shinhan-header.jsp" %>

<div class="contents">

    <h1 class="titDep1">연금펀드 검색</h1>

    <ul class="tabType vspace">

        <li><a href="#">이달의 펀드</a></li>

        <li class="on"><a href="#">수익률 Best 20</a></li>

        <li><a href="#">인기 판매 펀드</a></li>

        <li><a href="#">펀드검색</a></li>

    </ul>

    <div class="themeFundBest return vspace">

        <div class="themeFundOption">

            <p class="intro">Best Ranking</p>

            <h3 class="title">수익률</h3>

            <p class="info"><span id="fundPeriod">-</span> 기준입니다.</p>

        </div>

        <div class="visualRanking">

            <ol class="layoutTbl" id="fundRankList">

                <li class="data-loading">데이터 조회중...</li>

            </ol>

        </div>

    </div>

</div>

<%@ include file="include/shinhan-footer.jsp" %>

<script>$(function(){ Pension.init(); });</script>

