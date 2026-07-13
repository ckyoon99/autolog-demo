/**
 * Screen: 홈페이지 > 자산관리몰 > 장외채권매매
 * Author: 김신한
 * Desc: 장외채권매매 채권목록 Ajax 렌더링 로직
 * WR: WR26208-DP1(2026-07-07) 신규 화면
 * WR: WR26213-DP1(2026-07-13) 장외채권매매 채권상세 테이블(TB_OTC_BOND_DTL) 조인 조회 반영
 */
var WealthManagement = {

    init: function() {
        WealthManagement.loadList('/_WealthManagement01');

        $('.btnInq').on('click', function() {
            var bondNm = $('#inq_txt').val();
            WealthManagement.search(bondNm);
        });
    },

    loadList: function(url, data) {
        $.ajax({
            url: url,
            type: 'GET',
            data: data || {},
            dataType: 'json',
            success: function(res) {
                $('#investType').text(res.investType);
                WealthManagement.renderItems(res.items);
            },
            error: function() {
                $('#bondListBody').html('<tr><td colspan="10" class="data-loading">데이터를 불러올 수 없습니다.</td></tr>');
            }
        });
    },

    search: function(bondNm) {
        /* WR26213-DP1: 검색 클릭 시 상세 테이블 조인 쿼리 호출 */
        WealthManagement.loadList('/_WealthManagement01', {
            mode: 'search',
            bondNm: bondNm
        });
    },

    renderItems: function(items) {
        var html = '';
        $.each(items || [], function(i, item) {
            html += '<tr>';
            html += '<td><input type="checkbox" title="' + item.name + '"/></td>';
            html += '<td class="t_left prodName"><a href="#">' + item.name + '</a></td>';
            html += '<td>' + item.maturity + '</td><td>' + item.period + '</td><td>' + item.yield + '</td>';
            html += '<td>' + item.corpYield + '</td><td>' + item.genYield + '</td><td>' + item.credit + '</td>';
            html += '<td>' + item.risk + '</td>';
            html += '<td><a href="#" class="btnM btnBlue">매수</a></td>';
            html += '</tr>';
        });
        $('#bondListBody').html(html);
    }
};
