define(["jquery", "highcharts-theme"], function($, Highcharts) {
    "use strict";

    function ReportChart(data, id) {
        if (!(this instanceof ReportChart)) {
            throw new TypeError("Prediction constructor cannot be called as a function");
        }
        this.series_global = data;
        this.id = id;
        this.setSeries();

    }
    ReportChart.prototype = {



        setSeries : function() {
            var self = this;
            console.log(self);

            $('#daily_chart').highcharts('StockChart', {
                zoomType: 'x',

                navigator: {
                    enabled: true,
                    series: {
                        id: 'navigator'
                    }
                },

                credits: {
                    enabled: false
                },
                title: {
                    text: 'GBP/USD ' + self.id +  ' OHLC'
                },
                xAxis: {
                    type: 'datetime',
                    tickPixelInterval: 150
                },
                yAxis: {
                    title: {
                        text: 'Value'
                    },
                    plotLines: [{
                        value: 0,
                        width: 1,
                        color: '#808080'
                    }]
                },
                legend: {
                    enabled: false
                },
                exporting: {
                    enabled: false
                },
                series: [{
                    type: 'candlestick',
                    name: 'Random data',
                    data: self.series_global,
                    enableMouseTracking: false,
                    animation: false
                }]
            });
        }
    }

    return ReportChart;

});/**
 * Created by shaha1 on 27/01/15.
 */





