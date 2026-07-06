<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    request.setAttribute("pageTitle", "기업분석 | 신한투자증권");

    request.setAttribute("pageCss", "insights.css");

    request.setAttribute("wrapperClass", "wrapper");

    request.setAttribute("gnbActive", "gnb05");

%>

<%@ include file="include/shinhan-head.jsp" %>

<script src="/js/Investment.js"></script>

<%@ include file="include/shinhan-header.jsp" %>

<div class="contents">

    <h1 class="titDep1">기업분석</h1>

    <div class="boardList">

        <div class="boxGuide type02">

            <strong class="boxTit">Guide</strong>

            <ul class="listType1">

                <li>애널리스트가 작성한 기업분석 리포트, 뉴스, 실적 등의 자료를 게재합니다.</li>

                <li>본 조사분석자료는 당사 고객에 한하여 배포되는 자료입니다.</li>

            </ul>

        </div>

        <ul class="boardTypeCard type03" id="reportList">

            <li class="data-loading">데이터 조회중...</li>

        </ul>

    </div>

</div>

<%@ include file="include/shinhan-footer.jsp" %>

<script>$(function(){ Investment.init(); });</script>

