/**
 * Created by shaha1 on 06/03/15.
 */
var ok;
define(["jquery", "highcharts-theme"], function($, Highcharts) {
    "use strict";

    function ProfitChart(data, id) {
        if (!(this instanceof ProfitChart)) {
            throw new TypeError("Prediction constructor cannot be called as a function");
        }
        this.series_global = data;
        ok = data;
        this.id = id;
        this.setSeries();

    }
    ProfitChart.prototype = {



        setSeries : function() {
            var self = this;


            $('#daily_chart').highcharts('StockChart', {

                chart: {
                    zoomType: "x",
                    renderTo:'daily_chart',
                    marginRight: 10
                },

                title: {
                    text: 'GBP/USD ' + self.id +  ' Capital'
                },

                rangeSelector: {

                    buttons: [{
                        type: 'minute',
                        count: 1,
                        text: '1min'
                    }, {
                        type: 'day',
                        count: 1,
                        text: '1d'
                    }],
                    selected: 1
                },
                credits: {
                    enabled: false
                },

                series: [{
                    name: 'Capital',
                    enableMouseTracking: true,
                    data: self.series_global,
                    type: 'spline',
                    tooltip: {
                        valueDecimals: 2
                    }

                }]
            });
        }
    }

    return ProfitChart;

});/**
 * Created by shaha1 on 27/01/15.
 */





