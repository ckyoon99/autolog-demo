<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String gnbActive = (String) request.getAttribute("gnbActive");
    if (gnbActive == null) gnbActive = "";
%>
<div id="header" class="header">
    <div class="headArea">
        <div class="headTop">
            <p class="logo"><a href="/">신한투자증권</a></p>
            <ul class="topUtil">
                <li class="user">고객님</li>
                <li class="acct"><a href="#">개인정보변경</a></li>
                <li class="cert"><a href="#">로그아웃</a></li>
                <li class="premier dotNone"><a href="#">신한Premier</a></li>
                <li class="rks"><a href="/Pension">퇴직연금</a></li>
                <li class="catch"><a href="#"><strong>소비자보호포털</strong></a></li>
            </ul>
        </div>
        <div id="gnb" class="gnbArea">
            <ul class="gnbList">
                <li class="gnb01<%= "gnb01".equals(gnbActive) ? " gnbON" : "" %>"><a href="/MyAssets">나의 자산분석</a></li>
                <li class="gnb02<%= "gnb02".equals(gnbActive) ? " gnbON" : "" %>"><a href="/WealthManagement">자산관리몰</a></li>
                <li class="gnb03<%= "gnb03".equals(gnbActive) ? " gnbON" : "" %>"><a href="/Pension">연금자산</a></li>
                <li class="gnb04<%= "gnb04".equals(gnbActive) ? " gnbON" : "" %>"><a href="/Trading">트레이딩</a></li>
                <li class="gnb05<%= "gnb05".equals(gnbActive) ? " gnbON" : "" %>"><a href="/Investment">투자정보</a></li>
                <li class="gnb06"><a href="#">뱅킹/공모주/업무</a></li>
                <li class="gnb07"><a href="#">고객센터</a></li>
            </ul>
        </div>
    </div>
</div>
<div id="container" class="container">
