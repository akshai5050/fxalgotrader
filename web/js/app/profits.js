define(function (require) {
    //Do setup work here
    "use strict";
    var BasicStrategy = require("app/basic_strategy_profit");
    var basic_strategy_15 = new BasicStrategy(15);
    var BasicStrategySocketWrapper = require("app/basic_strategy_profit_socketwrapper");
    var basicStrategySocketWrapper = new BasicStrategySocketWrapper(4321, 15, basic_strategy_15.series_profit);
    basicStrategySocketWrapper.openConnection();


    var ConfidenceStrategy = require("app/confidence_strategy_profit");
    var confidence_strategy_15 = new ConfidenceStrategy(15);
    var ConfidenceStrategySocketWrapper = require("app/confidence_strategy_profit_socketwrapper");
    var confidenceStrategySocketWrapper = new ConfidenceStrategySocketWrapper(4321, 15, confidence_strategy_15.series_profit);
    confidenceStrategySocketWrapper.openConnection();

});

