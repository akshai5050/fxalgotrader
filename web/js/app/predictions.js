define(["jquery", "highcharts-theme", "app/SocketWrapper", "c"], function($, Highcharts, ws, c) {
    console.log($.fn.jquery);
    var series_actual;
    var series_prediction;
    $('#15_min_pred').highcharts('StockChart', {
        chart: {
            type: 'spline',
            animation: Highcharts.svg, // don't animate in old IE
            marginRight: 10,
            events: {
                load: function () {

                    // set up the updating of the chart each second
                    var series = this.series[0];
                    series_actual = series;
                    console.log("hello");
                    var series = this.series[1];
                    series_prediction = series;
                    new ws(4321, 15, series_actual, series_prediction).openConnection()
                }
            }
        },

        rangeSelector: {
            buttons: [{
                count: 1,
                type: 'minute',
                text: '1M'
            }, {
                count: 5,
                type: 'minute',
                text: '5M'
            }, {
                type: 'all',
                text: 'All'
            }, {
                count: 1,
                type: 'day',
                text: '1D'
            }],
            inputEnabled: false,
            selected: 0
        },
        title: {
            text: 'GBP/USD 30 Min OHLC Neural Net Predictions'
        },
        credits: {
            enabled: false
        },
        xAxis: {
            type: 'datetime',
            tickPixelInterval: 150
        },
        yAxis: {
            title: {
                text: 'Value'
            }
        },
        spline: {
            connectNulls: true
        },
        legend: {
            enabled: true
        },
        exporting: {
            enabled: false
        },


        series: [{
            name: 'Actual',
            enableMouseTracking: false
        }, {
            name: 'Prediction',
            enableMouseTracking: true
        }]
    });

    return xa;
});