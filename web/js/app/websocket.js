define(function() {

    function SocketWrapper(socket, tp, arr1, arr2) {
        this.series_actual = arr1;
        this.series_prediction = arr2;
        this.time_period = tp;
        this.socket = socket;
        this.ws = new WebSocket('ws://localhost:'.concat(socket));
        console.log(this.ws);
        this.ws.binaryType = 'arraybuffer';
        this.ws.onopen = function () {
            console.log("Open");
            console.log("asadasf");
        };
        this.ws.onclose = function () {
            console.log("Closed")
        };
        this.ws.onmessage = function (event) {
            console.log("onmesssage");
            data = JSON.parse(deserialize(event.data));
            this.dataHandler(data);
        };
        this.ws.onerror = function (error) {
            console.log("Error " + error.data);
        };
        this.ws.sendcmd = function (args) {
            if(arguments.length<=1) return false;
            var len = arguments.length,data = {},i;
            // First argument used as func property, rest are used as arg properties
            data['func'] = arguments[0];
            for(i = 1;i<len;i++){
                data['arg'+i] = arguments[i];
            }
            this.ws.send(serialize(JSON.stringify(data)));
        };

            this.dataHandler = function(data) {
                alert("fsafas");
                x  = data.data;
                switch(x.table) {
                    case "cdata":
                        // console.log(x.data);
                        var y =[new Date(x.data.dt*1000).getTime(), x.data.o, x.data.h, x.data.l, x.data.c];
                        ark = y;
                        series_global.addPoint(y, true);
                        break;
                    case "nnet_predictions":
                        console.log(x.data.actual);
                        var act =[new Date(x.data.dt*1000).getTime(), x.data.actual];
                        var pred =[new Date(x.data.dt*1000).getTime(), x.data.predictions];
                        this.series_actual.addPoint(act, true);
                        this.series_prediction.addPoint(pred, true);
                        break;

                }
            };
        console.log(this.ws);

    };
    return SocketWrapper;
});





    // WebSocket event handlers






