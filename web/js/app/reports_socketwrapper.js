var days_hashmap = {};
var days_profit_hashmap = {};
var na = 1;
var received_all_data = 0;
var received_performance_data = 0;
var formatted_date;

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
            var performance;
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
                    formatted_date = day + "/" + month + "/" + year;
                    console.log(day + "/" + month + "/" + year);
                    days_hashmap[formatted_date] = data;
                    console.log(days_hashmap);
                    received_all_data += 0.5;
                    break;
                case "trading_day":
                    data = x.data;
                    console.log(data);
                    var date = new Date(data[0]["dt"]*1000);
                    var d = date.getDate();
                    var day = (d < 10) ? '0' + d : d;
                    var m = date.getMonth() + 1;
                    var month = (m < 10) ? '0' + m : m;
                    var yy = date.getYear();
                    var year = (yy < 1000) ? yy + 1900 : yy;
                    formatted_date = day + "/" + month + "/" + year;
                    days_profit_hashmap[formatted_date] = data;
                    received_all_data += 0.5;
                    console.log("Receiving trading day data" + formatted_date);
                    break;
                case "trading_day_performance":
                    console.log("PERFORMANCE" + formatted_date);
                    data = x.data;
                    console.log(x.data);

                    if (data["percentage_difference"] >= 0) {
                        console.log("Data up");
                        performance = "<td>" + data["starting_profit"] + "</td><td>" + data["finishing_profit"] + "</td><td class=\"green\"><span class=\"glyphicon green glyphicon-arrow-up\"></span>" + data["percentage_difference"].toFixed(2) + "%</td>";
                    } else {
                        console.log("Data down");
                        performance = "<td>" + data["starting_profit"] + "</td><td>" + data["finishing_profit"] + "</td><td class=\"red\"><span class=\"glyphicon red glyphicon-arrow-down\"></span>" + data["percentage_difference"].toFixed(2) + "%</td>";
                    }
                    received_performance_data = 1;
                    break;
            }
            if (received_all_data == 1 && received_performance_data == 1) {
                console.log("received all data!!!!" + performance);
                $("#report_table tbody").append("<tr><td>" + formatted_date + "</td><td><button id=" + formatted_date + " type=\"button\" class=\"btn btn-primary report-btn\" data-toggle=\"modal\" data-target=\"#myModal\">OHLC</button></td><td><button id=" + formatted_date + " type=\"button\" class=\"btn btn-primary report-profit-btn\" data-toggle=\"modal\" data-target=\"#myModal\">Capital</button></td>" + performance + "</tr>" );
                received_all_data = 0;
                received_performance_data = 0;
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
