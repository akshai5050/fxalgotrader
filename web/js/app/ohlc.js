define(["jquery", "highcharts-theme"], function($, Highcharts) {
    "use strict";

    function Prediction(tf) {
        if (!(this instanceof Prediction)) {
            throw new TypeError("Prediction constructor cannot be called as a function");
        }
        this.timeframe = tf;
        this.series_global;
        this.setSeries();

    }

    Prediction.prototype = {



        setSeries : function() {
            var self = this;
            console.log(self);

            $('#' + self.timeframe +'_min_ohlc').highcharts('StockChart', {
                zoomType: 'x',
                animation: Highcharts.svg, // don't animate in old IE
                rangeSelector : {
                    buttons: [{
                        type: 'hour',
                        count: 1,
                        text: '1h'
                    }, {
                        type: 'day',
                        count: 1,
                        text: '1d'
                    }, {
                        type: 'month',
                        count: 1,
                        text: '1m'
                    }, {
                        type: 'year',
                        count: 1,
                        text: '1y'
                    }, {
                        type: 'all',
                        text: 'All'
                    }],
                    inputEnabled: false, // it supports only days
                    selected : 1 // day
                },

                credits: {
                    enabled: false
                },

                navigator: {
                    adaptToUpdatedData: true
                },
                chart: {
                    renderTo: 'container',
                    type: 'ohlc',
                    marginRight: 10,
                    events: {
                        load: function () {

                            // set up the updating of the chart each second
                            self.series_global = this.series[0];
                        }
                    }
                },
                title: {
                    text: 'GBP/USD ' + self.timeframe +  ' Min OHLC'
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
                    enableMouseTracking: false
                }]
            });
        }
    }

    return Prediction;

});/**
 * Created by shaha1 on 27/01/15.
 */





