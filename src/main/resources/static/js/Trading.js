var Trading = {

    init: function() {

        $.ajax({

            url: '/_Trading01',

            type: 'GET',

            dataType: 'json',

            success: function(data) {

                $('#inq_dateFrom').val(data.dateFrom);

                $('#inq_dateTo').val(data.dateTo);

                var html = '';

                $.each(data.items, function(i, item) {

                    html += '<tr>';

                    html += '<td>' + item.date + '</td><td>' + item.time + '</td><td>' + item.rate + '</td>';

                    html += '<td>' + item.sellCurr + '</td><td class="t_right">' + item.sellAmt + '</td>';

                    html += '<td>' + item.buyCurr + '</td><td class="t_right">' + item.buyAmt + '</td>';

                    html += '</tr>';

                });

                $('#fxListBody').html(html);

            },

            error: function() {

                $('#fxListBody').html('<tr><td colspan="7" class="data-loading">데이터를 불러올 수 없습니다.</td></tr>');

            }

        });

    }

};

