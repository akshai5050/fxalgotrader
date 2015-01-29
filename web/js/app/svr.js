define(["jquery", "highcharts-theme"], function($, Highcharts) {
    "use strict";

    function Svr(tf) {
        if (!(this instanceof Svr)) {
            throw new TypeError("Prediction constructor cannot be called as a function");
        }
        this.timeframe = tf;
        this.series_actual;
        this.series_prediction;
        this.setSeries();

    }

    Svr.prototype = {



        setSeries : function() {
            var self = this;
            console.log(self);

            $('#' + self.timeframe +'_min_svr').highcharts('StockChart', {
                chart: {
                    type: 'spline',
                    animation: Highcharts.svg, // don't animate in old IE
                    marginRight: 10,
                    events: {
                        load: function () {
                            console.log(self);
                            // set up the updating of the chart each second
                            //this.setSeries(this.series[0], this.series[1]);
                            //this.series_prediction = this.series[1];
                            self.series_actual = this.series[0];
                            self.series_prediction = this.series[1];
                            console.log(self);
                            //new ws(4321, 15, series_actual, series_prediction).openConnection()
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
                    text: 'GBP/USD ' + this.timeframe + ' SVR'
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
        }
    }

    return Svr;

});/**
 * Created by shaha1 on 27/01/15.
 */





