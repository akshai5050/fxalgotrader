
requirejs.config({
    //By default load any module IDs from js/lib
    baseUrl: 'js/lib',
    //except, if the module ID starts with "app",
    //load it from the js/app directory. paths
    //config is relative to the baseUrl, and
    //never includes a ".js" extension since
    //the paths config could be for a directory.
    paths: {
        app: '../app',
        "jquery": "http://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min",
        'highcharts-theme': "highcharts/themes/dark-unica",
        "highcharts": "highcharts/highstock",
        "ws": "../app/websocket",
        "indicators": "highcharts/indicators",
        "ema": "https://rawgit.com/blacklabel/indicators/master/js/ema"
    },
    shim: {
        highcharts: {
            deps: ['jquery'],
            exports: 'Highcharts'
        },
        'highcharts-theme': {
            deps: ['highcharts'],
            exports: 'Highcharts'
        },
        'ws':{
            'exports': 'web'
        },
        'indicators':{
            deps: ['highcharts-theme'],
            exports: 'Indicators'
        },
        'ema':{
            deps: ['indicators'],
            exports: 'Ema'
        }
    }
});

requirejs(["app/main"]);