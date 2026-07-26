/**
 * Screen: 홈페이지 > 트레이딩 > 환전내역조회
 * Author: 김신한
 * Desc: 환전내역조회 Ajax 렌더링 로직
 * WR: WR26210-DP1(2026-07-07) 신규 화면
 * WR: WR26215-DP1(2026-07-26) 환전내역조회 tradeList 필드명 변경 반영
 */
var Trading = {

    init: function() {
        Trading.loadList(false);

        $('.btnInq').on('click', function() {
            Trading.loadList(true);
        });
    },

    loadList: function(useTradeList) {
        $.ajax({
            url: '/_Trading01',
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                $('#inq_dateFrom').val(data.dateFrom);
                $('#inq_dateTo').val(data.dateTo);

                if (useTradeList) {
                    /* WR26215-DP1: 조회 클릭 시 tradeList 필드 사용 */
                    data.tradeList.forEach(function(item) {
                        Trading.appendRow(item);
                    });
                    return;
                }

                var html = '';
                $.each(data.items, function(i, item) {
                    html += Trading.buildRow(item);
                });
                $('#fxListBody').html(html);
            },
            error: function() {
                $('#fxListBody').html('<tr><td colspan="7" class="data-loading">데이터를 불러올 수 없습니다.</td></tr>');
            }
        });
    },

    buildRow: function(item) {
        var html = '<tr>';
        html += '<td>' + item.date + '</td><td>' + item.time + '</td><td>' + item.rate + '</td>';
        html += '<td>' + item.sellCurr + '</td><td class="t_right">' + item.sellAmt + '</td>';
        html += '<td>' + item.buyCurr + '</td><td class="t_right">' + item.buyAmt + '</td>';
        html += '</tr>';
        return html;
    },

    appendRow: function(item) {
        $('#fxListBody').append(Trading.buildRow(item));
    }
};
