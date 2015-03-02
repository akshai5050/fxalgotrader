define(function (require) {
    //Do setup work here
    "use strict";
    var NnetError = require("app/nnet_error");
    var nnet_error_15 = new NnetError(15);
    var NnetErrorSocketWrapper = require("app/nnet_error_socketwrapper");
    var nnetErrorSocketWrapper = new NnetErrorSocketWrapper(4321, 15, nnet_error_15.series_profit);
    nnetErrorSocketWrapper.openConnection();

    var SvrError = require("app/svr_error");
    var svr_error_15 = new SvrError(15);
    var SvrErrorSocketWrapper = require("app/svr_error_socketwrapper");
    var svrErrorSocketWrapper = new SvrErrorSocketWrapper(4321, 15, svr_error_15.series_profit);
    svrErrorSocketWrapper.openConnection();

    var ArimaError = require("app/arima_error");
    var arima_error_15 = new ArimaError(15);
    var ArimaErrorSocketWrapper = require("app/arima_error_socketwrapper");
    var arimaErrorSocketWrapper = new ArimaErrorSocketWrapper(4321, 15, arima_error_15.series_profit);
    arimaErrorSocketWrapper.openConnection();

    var CombinedError = require("app/combined_error");
    var combined_error_15 = new CombinedError(15);
    var CombinedErrorSocketWrapper = require("app/combined_error_socketwrapper");
    var combinedErrorSocketWrapper = new CombinedErrorSocketWrapper(4321, 15, combined_error_15.series_profit);
    combinedErrorSocketWrapper.openConnection();


});

