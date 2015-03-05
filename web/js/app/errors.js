define(function (require) {
    //Do setup work here
    "use strict";
    var NnetError = require("app/nnet_error");
    var nnet_error_15 = new NnetError(15);
    var NnetErrorSocketWrapper = require("app/nnet_error_socketwrapper");
    var nnetErrorSocketWrapper = new NnetErrorSocketWrapper(4321, 15, nnet_error_15.nnet_error);
    nnetErrorSocketWrapper.openConnection();


    var SvrErrorSocketWrapper = require("app/svr_error_socketwrapper");
    var svrErrorSocketWrapper = new SvrErrorSocketWrapper(4321, 15, nnet_error_15.svr_error);
    svrErrorSocketWrapper.openConnection();


    var ArimaErrorSocketWrapper = require("app/arima_error_socketwrapper");
    var arimaErrorSocketWrapper = new ArimaErrorSocketWrapper(4321, 15, nnet_error_15.arima_error);
    arimaErrorSocketWrapper.openConnection();


    var CombinedErrorSocketWrapper = require("app/combined_error_socketwrapper");
    var combinedErrorSocketWrapper = new CombinedErrorSocketWrapper(4321, 15, nnet_error_15.combined_error);
    combinedErrorSocketWrapper.openConnection();


});

