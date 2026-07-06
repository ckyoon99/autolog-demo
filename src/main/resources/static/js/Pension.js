var Pension = {

    init: function() {

        $.ajax({

            url: '/_Pension01',

            type: 'GET',

            dataType: 'json',

            success: function(data) {

                $('#fundPeriod').text(data.period);

                var html = '';

                var items = (data.items || []).slice(0, 3);

                $.each(items, function(i, item) {

                    var types = '';

                    $.each(item.types, function(j, t) {

                        types += '<span class="prodType">' + t + '</span>';

                    });

                    html += '<li>';

                    html += '<p class="ranking">' + item.rank + '</p>';

                    html += '<strong class="title">' + item.name + '</strong>';

                    html += '<dl class="typeInfo"><dt>수익률</dt><dd><span>' + item.returnRate + '</span><span class="unit">%</span></dd></dl>';

                    html += '<div class="productType"><p class="row">' + types + '</p></div>';

                    html += '<a href="#" class="btnView">상세보기</a>';

                    html += '</li>';

                });

                $('#fundRankList').html(html);

            },

            error: function() {

                $('#fundRankList').html('<li class="data-loading">데이터를 불러올 수 없습니다.</li>');

            }

        });

    }

};

