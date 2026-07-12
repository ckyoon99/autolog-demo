/**
 * Screen: 홈페이지 > 나의 자산분석 > 전계좌현황
 * Author: 김신한
 * Desc: 전계좌현황 Ajax 렌더링 및 자산구성 원그래프 표시 로직
 * WR: WR26207-DP1(2026-07-07) 신규 화면
 * WR: WR26212-DP1(2026-07-12) 전계좌현황 자산구성 원그래프 composition 필드 연동
 */
var MyAssets = {
    init: function() {
        $.ajax({
            url: '/_MyAssets01',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                MyAssets.renderSummary(data);
                MyAssets.renderPrimary(data.primaryAcct);
                MyAssets.renderPieChart(data.primaryAcct);
                MyAssets.renderMore(data.accounts);
            },
            error: function() {
                $('#totalAsset').text('-');
                $('#acctMoreArea').html('<p class="data-loading vspace">데이터를 불러올 수 없습니다.</p>');
            }
        });
    },

    renderSummary: function(data) {
        $('#totalAsset').text(MyAssets.formatNum(data.totalAsset));
        $('#currentDate').text(data.currentDate);
    },

    renderPrimary: function(acct) {
        if (!acct) return;
        $('#primaryAcctNo').text(acct.no);
        $('#primaryAcctName').text(acct.name);
        $('#primaryAcctType').text(acct.type);
        $('#acctTotal').text(MyAssets.formatNum(acct.total));
        $('#withdrawAmt').text(MyAssets.formatNum(acct.withdraw));
        $('#finProd').text(MyAssets.formatNum(acct.finProd));
        $('#stockAmt').text(MyAssets.formatNum(acct.stock));
        $('#depositAmt').text(MyAssets.formatNum(acct.deposit));
    },

    renderPieChart: function(acct) {
        if (!acct) return;
        /* WR26212-DP1: composition 객체로 차트 렌더 */
        var composition = acct.composition;
        var result = AssetPieChart.render('assetPieChart', composition);
        $('#finProdPct').text(result.pcts[0]);
        $('#stockPct').text(result.pcts[1]);
        $('#depositPct').text(result.pcts[2]);
    },

    renderMore: function(accounts) {
        if (!accounts || !accounts.length) {
            $('#acctMoreArea').empty();
            return;
        }
        var html = '';
        $.each(accounts, function(i, acct) {
            html += '<div class="prodStatus">';
            html += '<div class="statTit">';
            html += '<h2 class="tit"><span>' + acct.no + '</span>&nbsp;<span>' + acct.name + '</span></h2>';
            html += '<span class="icoProduct type1">' + acct.type + '</span>';
            html += '<div class="btn"><a href="#" class="btnM">상세잔고</a></div>';
            html += '</div>';
            html += '<div class="statCons"><ul class="statTxt">';
            html += '<li>총 금액 <span class="data"><strong class="type2 colPoint02">' + MyAssets.formatNum(acct.total) + '</strong>원</span></li>';
            html += '</ul></div></div>';
        });
        $('#acctMoreArea').html(html);
    },

    formatNum: function(n) {
        return Number(n).toLocaleString();
    }
};
