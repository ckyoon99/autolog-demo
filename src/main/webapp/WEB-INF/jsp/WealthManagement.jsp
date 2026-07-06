<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    request.setAttribute("pageTitle", "장외채권매매 | 신한투자증권");

    request.setAttribute("pageCss", "wealth-management.css");

    request.setAttribute("wrapperClass", "wrapper wealthWrap type1");

    request.setAttribute("gnbActive", "gnb02");

%>

<%@ include file="include/shinhan-head.jsp" %>

<script src="/js/WealthManagement.js"></script>

<%@ include file="include/shinhan-header.jsp" %>

<div class="contents">

    <h1 class="titDep1">장외채권매매</h1>

    <ul class="tabType">

        <li class="on"><a href="#">전체상품</a></li>

        <li><a href="#">내역조회/취소</a></li>

    </ul>

    <fieldset class="boxInquiry bgForm vspace">

        <legend>청약중인 상품검색</legend>

        <ul class="inqInfo">

            <li>

                <div class="inqTit"><label for="inq_txt">채권명</label></div>

                <div class="inqCon">

                    <input id="inq_txt" type="text" style="width:570px" placeholder="채권명(채권코드)을 입력하세요." maxlength="100"/>

                </div>

            </li>

        </ul>

        <button type="button" class="btnL btnInq">검색</button>

    </fieldset>

    <p class="fundLevelBox">

        <span class="colPoint01">고객</span>님의 성향은 <em class="txtInvest type05" id="investType">조회중...</em>입니다.

    </p>

    <table class="tblH prodList" summary="장외채권매매 매수 리스트">

        <caption>장외채권매매 매수 리스트</caption>

        <thead>

        <tr>

            <th scope="col" rowspan="2">선택</th>

            <th scope="col" rowspan="2">종목명</th>

            <th scope="col" rowspan="2">만기일</th>

            <th scope="col" rowspan="2">투자기간</th>

            <th scope="col" rowspan="2">매수수익률<br/>(세전, 연)</th>

            <th scope="col" colspan="2">은행환산수익률<br/>(세전, 연)</th>

            <th scope="col" rowspan="2">신용<br/>등급</th>

            <th scope="col" rowspan="2">상품<br/>위험등급</th>

            <th scope="col" rowspan="2">매수</th>

        </tr>

        <tr>

            <th scope="col" class="lineL">법인</th>

            <th scope="col">일반</th>

        </tr>

        </thead>

        <tbody id="bondListBody">

        <tr><td colspan="10" class="data-loading">데이터 조회중...</td></tr>

        </tbody>

    </table>

</div>

<%@ include file="include/shinhan-footer.jsp" %>

<script>$(function(){ WealthManagement.init(); });</script>

