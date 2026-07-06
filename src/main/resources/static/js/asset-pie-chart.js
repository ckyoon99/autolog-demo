/**
 * 자산 구성 원그래프 (Chart.js 래퍼)
 * - 라이브러리: Chart.js 4.x (CDN)
 * - 추후 에러 로그 데모: render() 실패·데이터 오류 시 throw
 */
var AssetPieChart = {
    COLORS: {
        finProd:  '#5f82d2',
        stock:    '#314689',
        deposit:  '#b799ff'
    },
    LABELS: ['금융상품', '주식', '예수금'],
    KEYS:   ['finProd', 'stock', 'deposit'],

    _instance: null,

    render: function(canvasId, acct) {
        if (typeof Chart === 'undefined') {
            throw new Error('Chart.js is not loaded');
        }
        var canvas = document.getElementById(canvasId);
        if (!canvas) {
            throw new Error('Canvas not found: ' + canvasId);
        }

        var values = [
            Number(acct.finProd) || 0,
            Number(acct.stock) || 0,
            Number(acct.deposit) || 0
        ];
        var total = values.reduce(function(a, b) { return a + b; }, 0);
        if (total <= 0) {
            throw new Error('AssetPieChart: total amount is zero');
        }

        var colors = [
            AssetPieChart.COLORS.finProd,
            AssetPieChart.COLORS.stock,
            AssetPieChart.COLORS.deposit
        ];

        if (AssetPieChart._instance) {
            AssetPieChart._instance.destroy();
        }

        AssetPieChart._instance = new Chart(canvas, {
            type: 'doughnut',
            data: {
                labels: AssetPieChart.LABELS,
                datasets: [{
                    data: values,
                    backgroundColor: colors,
                    borderColor: '#fff',
                    borderWidth: 2,
                    hoverOffset: 6
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                cutout: '55%',
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(ctx) {
                                var val = ctx.raw;
                                var pct = ((val / total) * 100).toFixed(1);
                                return ctx.label + ': ' + val.toLocaleString() + '원 (' + pct + '%)';
                            }
                        }
                    }
                }
            }
        });

        AssetPieChart.renderLegend(values, total);
        return { values: values, total: total, pcts: values.map(function(v) {
            return total > 0 ? ((v / total) * 100).toFixed(1) : '0';
        })};
    },

    renderLegend: function(values, total) {
        var html = '';
        for (var i = 0; i < AssetPieChart.LABELS.length; i++) {
            var pct = total > 0 ? ((values[i] / total) * 100).toFixed(1) : '0';
            var color = [AssetPieChart.COLORS.finProd, AssetPieChart.COLORS.stock, AssetPieChart.COLORS.deposit][i];
            html += '<span><i style="background:' + color + '"></i>' +
                AssetPieChart.LABELS[i] + ' ' + pct + '%</span>';
        }
        $('#assetPieLegend').html(html);
    },

    destroy: function() {
        if (AssetPieChart._instance) {
            AssetPieChart._instance.destroy();
            AssetPieChart._instance = null;
        }
    }
};
