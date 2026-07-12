<%--
 * Screen: 홈페이지 > 나의 자산분석 > 전계좌현황
 * Author: 김신한
 * Desc: 전계좌현황 뷰페이지
 * WR: WR26207-DP1(2026-07-07) 신규 화면
 * WR: WR26212-DP1(2026-07-12) 전계좌현황 자산구성 원그래프 composition 필드 연동
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    request.setAttribute("pageTitle", "전계좌현황 | 신한투자증권");

    request.setAttribute("pageCss", "myasset.css");

    request.setAttribute("wrapperClass", "wrapper myassetWrap");

    request.setAttribute("gnbActive", "gnb01");

%>

<%@ include file="include/shinhan-head.jsp" %>

<link rel="stylesheet" href="/css/myasset-chart.css"/>

<script src="/js/chart.min.js"></script>

<script src="/js/asset-pie-chart.js"></script>

<script src="/js/MyAssets.js"></script>

<%@ include file="include/shinhan-header.jsp" %>

<div class="contents">

    <h1 class="titDep1">전계좌현황</h1>

    <div class="boxReport">

        <div class="repCon money">

            <em class="h">총 자산</em>

            <span class="num"><strong id="totalAsset">조회중...</strong> 원</span>

            <span class="txt">(<span id="currentDate">-</span> 현재)</span>

        </div>

        <p class="formWrap txt">

            <input type="checkbox" id="check1"><label for="check1">잔고순</label>

        </p>

    </div>

    <div id="acctListArea">

        <div class="prodStatus">

            <div class="statTit">

                <h2 class="tit"><span id="primaryAcctNo">-</span>&nbsp;<span id="primaryAcctName">-</span></h2>

                <span class="icoProduct type1" id="primaryAcctType">-</span>

                <div class="btn">

                    <a href="#" class="btnM">상세잔고</a>

                    <a href="#" class="btnM">입출금내역</a>

                    <a href="#" class="btnM">이체</a>

                </div>

            </div>

            <div class="statCons">

                <ul class="statTxt">

                    <li>총 금액(100%) <span class="data"><strong class="type2 colPoint02" id="acctTotal">-</strong>원</span><br>

                        출금가능금액 <span class="data"><strong class="type2 colPoint02" id="withdrawAmt">-</strong>원</span>

                        <ul class="depTxt">

                            <li>금융상품 <span class="data"><strong id="finProd">-</strong>원 (<span id="finProdPct">-</span>%)</span></li>

                            <li>주식 <span class="data"><strong id="stockAmt">-</strong>원 (<span id="stockPct">-</span>%)</span></li>

                            <li>예수금 <span class="data"><strong id="depositAmt">-</strong>원 (<span id="depositPct">-</span>%)</span></li>

                        </ul>

                    </li>

                </ul>

                <div class="statGrp">

                    <div class="pieGrp">

                        <div class="asset-pie-wrap">

                            <canvas id="assetPieChart" width="380" height="320"></canvas>

                        </div>

                        <p class="asset-pie-legend" id="assetPieLegend"></p>

                    </div>

                </div>

            </div>

        </div>

    </div>

    <div id="acctMoreArea"></div>

    <div class="boxDown vspace">

        <p>※ <span class="colPoint01">휴면계좌</span>가 있으신지 확인해 보세요.</p>

        <a href="#" class="btnM">휴면계좌확인</a>

    </div>

</div>

<%@ include file="include/shinhan-footer.jsp" %>

<script>$(function(){ MyAssets.init(); });</script>

