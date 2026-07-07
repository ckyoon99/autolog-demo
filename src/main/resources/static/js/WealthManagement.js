/**
 * Screen: 홈페이지 > 자산관리몰 > 장외채권매매
 * Author: 김신한
 * Desc: 장외채권매매 채권목록 Ajax 렌더링 로직
 * WR: WR26208-DP1(2026-07-07) 신규 화면
 */
var WealthManagement = {

    init: function() {

        $.ajax({

            url: '/_WealthManagement01',

            type: 'GET',

            dataType: 'json',

            success: function(data) {

                $('#investType').text(data.investType);

                var html = '';

                $.each(data.items, function(i, item) {

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

            },

            error: function() {

                $('#bondListBody').html('<tr><td colspan="10" class="data-loading">데이터를 불러올 수 없습니다.</td></tr>');

            }

        });

    }

};

