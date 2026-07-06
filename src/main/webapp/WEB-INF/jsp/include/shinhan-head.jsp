<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    String pageCss = (String) request.getAttribute("pageCss");
    String wrapperClass = (String) request.getAttribute("wrapperClass");
    if (pageTitle == null) pageTitle = "신한투자증권";
    if (wrapperClass == null) wrapperClass = "wrapper";
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title><%= pageTitle %></title>
    <link rel="shortcut icon" href="/images/shinhan.ico"/>
    <link rel="stylesheet" href="/css/shinhan/ui-loading.css"/>
    <link rel="stylesheet" href="/css/shinhan/common.css"/>
<% if (pageCss != null && !pageCss.isEmpty()) { %>
    <link rel="stylesheet" href="/css/shinhan/<%= pageCss %>"/>
<% } %>
    <link rel="stylesheet" href="/css/shinhan/demo-fix.css"/>
    <script src="/js/jquery-3.6.0.min.js"></script>
    <script src="/js/Logger.js"></script>
</head>
<body>
<div id="wrapper" class="<%= wrapperClass %>">
