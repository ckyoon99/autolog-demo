<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    request.setAttribute("pageTitle", "신한투자증권 | 메인");

    request.setAttribute("pageCss", "");

    request.setAttribute("wrapperClass", "wrapper mainWrap");

    request.setAttribute("gnbActive", "");

%>

<%@ include file="include/shinhan-head.jsp" %>

<link rel="stylesheet" href="/css/main-home.css"/>

<%@ include file="include/shinhan-header.jsp" %>

<div class="contents main-home">

    <div class="main-hero">

        <ul class="main-cards">

            <li>

                <a class="main-card" href="/MyAssets">

                    <span class="sub">변동성 심한 시대에<br/>대안 상품</span>

                    <strong class="tit">청약 가능한 <em>ELS</em>는?</strong>

                </a>

            </li>

            <li>

                <a class="main-card main-card--primary" href="/WealthManagement">

                    <span class="sub">Grand OPEN</span>

                    <strong class="tit">공모주, 여기서 한번에<br/>신청하세요!</strong>

                </a>

            </li>

        </ul>

    </div>

    <div class="main-banners">

        <p class="assetTit"><strong>자산관리,</strong> 신한투자증권과 함께 하세요!</p>

        <ul class="btmBanner">

            <li><a href="/MyAssets"><strong>나의 자산현황</strong>전 계좌 자산 통합 조회</a></li>

            <li><a href="/WealthManagement"><strong>자산관리몰</strong>장외채권 · 펀드 · ELS</a></li>

            <li><a href="/Pension"><strong>연금자산</strong>연금펀드 검색</a></li>

        </ul>

    </div>

</div>

<%@ include file="include/shinhan-footer.jsp" %>

