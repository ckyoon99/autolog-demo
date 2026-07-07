/**
 * Screen: 홈페이지 > 투자정보 > 기업분석
 * Author: 김신한
 * Desc: 기업분석 리포트목록 Ajax 렌더링 로직
 * WR: WR26211-DP1(2026-07-07) 신규 화면
 */
var Investment = {

    init: function() {

        $.ajax({

            url: '/_Investment01',

            type: 'GET',

            dataType: 'json',

            success: function(data) {

                var html = '';

                $.each(data.items, function(i, item) {

                    html += '<li class="box">';

                    html += '<strong class="tit"><a href="#">' + item.title + '</a></strong>';

                    html += '<ul class="listType1">';

                    html += '<li><strong class="h">종목명</strong> <span class="d">' + item.stock + '</span></li>';

                    html += '<li><strong class="h">투자의견</strong> <span class="d">' + item.opinion + '</span></li>';

                    html += '</ul>';

                    html += '<p class="cont">' + item.summary + '</p>';

                    html += '<div class="info"><span>' + item.analyst + '</span><span class="stick">|</span><span>' + item.date + '</span></div>';

                    html += '<a href="#" class="down">PDF다운로드</a>';

                    html += '</li>';

                });

                $('#reportList').html(html);

            },

            error: function() {

                $('#reportList').html('<li class="data-loading">데이터를 불러올 수 없습니다.</li>');

            }

        });

    }

};

