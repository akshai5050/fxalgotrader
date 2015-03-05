var days_hashmap = {};
var na = 1;
define(["c", "jquery", "bootstrap"], function(c, $, bootstrap) {
    "use strict";

    function Reports(socket) {
        if (!(this instanceof Reports)) {
            throw new TypeError("BasicStrategySocketWrapper constructor cannot be called as a function");
        }
        this.socket = socket;
        this.ws = new WebSocket("ws://localhost:" + socket);
        //this.tp = tp;
        //this.actual = arr1;
        //this.prediction = arr2;
    }




    Reports.prototype = {

        openConnection : function() {

            var self = this;

            this.ws.onopen = function() {
                console.log("Connected to nnet error socketwrapper");
                this.binaryType = 'arraybuffer'
                this.sendcmd("sum",1,2)
            }
            this.ws.onmessage = function(event) {
                var data = JSON.parse(deserialize(event.data));
                self.dataHandler(data);
            }
            this.ws.onclose = function() {
                console.log("DIsconnected");
            }

            this.ws.sendcmd = function (args) {
                if(arguments.length<=1) return false;
                var len = arguments.length,data = {},i;
                // First argument used as func property, rest are used as arg properties
                data['func'] = arguments[0];
                for(i = 1;i<len;i++){
                    data['arg'+i] = arguments[i];
                }
                this.send(serialize(JSON.stringify(data)));
            };


        },

        dataHandler : function(data) {
            var x  = data.data;
            switch(x.table) {
                case "ohlc_day":
                    console.log(x.data);
                    data = x.data;
                    var date = new Date(data[0]["start_dt"]*1000);
                    var d = date.getDate();
                    var day = (d < 10) ? '0' + d : d;
                    var m = date.getMonth() + 1;
                    var month = (m < 10) ? '0' + m : m;
                    var yy = date.getYear();
                    var year = (yy < 1000) ? yy + 1900 : yy;
                    var formatted_date = day + "/" + month + "/" + year;
                    console.log(day + "/" + month + "/" + year);
                    days_hashmap[formatted_date] = data;
                    console.log(days_hashmap);
                        $("#report_table tbody").append("<tr><td>" + formatted_date + "</td><td><button id=" + formatted_date + " type=\"button\" class=\"btn btn-primary report-btn\" data-toggle=\"modal\" data-target=\"#myModal\">OHLC</button></td></tr>");
                    //var act =[new Date(x.data.dt*1000).getTime(), x.data.actual];
                    //var pred =[new Date(x.data.dt*1000).getTime(), x.data.predictions];
                    //var profit =[new Date(x.data.dt*1000).getTime(), x.data.mape];
                    //console.log(x.data.mape);
                    //this.series_actual.addPoint(act, true);
                    //console.log(x.data.actual);
                    //this.series_prediction.addPoint(pred, true);
                    //this.series_profit.addPoint(profit, true);
                    break;

            }
        }
    }

    return Reports;

});/**
 * Created by shaha1 on 30/01/15.
 */
/**
 * Created by shaha1 on 04/03/15.
 */
