define(["jquery", "highcharts-theme"], function($, Highcharts) {
    "use strict";

    function BasicStrategyProfit(tf) {
        if (!(this instanceof BasicStrategyProfit)) {
            throw new TypeError("Prediction constructor cannot be called as a function");
        }
        this.timeframe = tf;
        this.series_profit;
        this.setSeries();

    }

    BasicStrategyProfit.prototype = {



        setSeries : function() {
            var self = this;
            console.log(self);

            $('#basic_strategy').highcharts({
                chart: {
                    zoomType: 'x',
                    animation: Highcharts.svg, // don't animate in old IE
                    marginRight: 10,
                    events: {
                        load: function () {
                            console.log(self);
                            // set up the updating of the chart each second
                            //this.setSeries(this.series[0], this.series[1]);
                            //this.series_prediction = this.series[1];
                            self.series_profit = this.series[0];
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
                    text: 'Basic Strategy Capital'
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
                        text: '£'
                    }
                },
                spline: {
                    connectNulls: true
                },
                legend: {
                    enabled: false
                },

                plotOptions: {
                    area: {
                        fillColor: {
                            linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1},
                            stops: [
                                [0, Highcharts.getOptions().colors[0]],
                                [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0).get('rgba')]
                            ]
                        },
                        marker: {
                            radius: 2
                        },
                        lineWidth: 1,
                        states: {
                            hover: {
                                lineWidth: 1
                            }
                        },
                        threshold: null
                    }
                },
                exporting: {
                    enabled: false
                },


                series: [{
                    type: 'area',
                    name: 'Capital',
                    enableMouseTracking: false,
                    marker: {
                        enabled: false
                    }
                }]
            });
        }
    }

    return BasicStrategyProfit;

});/**
 * Created by shaha1 on 27/01/15.
 */





/**
 * Created by shaha1 on 30/01/15.
 */
