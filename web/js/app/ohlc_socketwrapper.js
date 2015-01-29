/**
 * Created by shaha1 on 27/01/15.
 */
define(["c"], function(c) {
    "use strict";

    function SocketWrapper(socket, tf, series_global) {
        if (!(this instanceof SocketWrapper)) {
            throw new TypeError("SocketWrapper constructor cannot be called as a function");
        }
        this.socket = socket;
        this.tf = tf;
        this.series_global = series_global;
        this.ws = new WebSocket("ws://localhost:" + socket);
        //this.tp = tp;
        //this.actual = arr1;
        //this.prediction = arr2;
    }




    SocketWrapper.prototype = {

        openConnection : function() {

            var self = this;

            this.ws.onopen = function() {
                console.log("Connected to ohlc");
                this.binaryType = 'arraybuffer'
                this.sendcmd("sum",1,2)
            }
            this.ws.onmessage = function(event) {
                var data = JSON.parse(deserialize(event.data));
                self.dataHandler(data);
            }
            this.ws.onclose = function() {
                console.log("Disconnected");
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
                this.send(serialize(JSON.stringify(data)));
            };


        },

        dataHandler : function(data) {
            var x  = data.data;
            switch(x.table) {
                case "cdata":
                    var y =[new Date(x.data.dt*1000).getTime(), x.data.o, x.data.h, x.data.l, x.data.c];
                    this.series_global.addPoint(y, true);
                    break;
            }
        }
    }

    return SocketWrapper;

});