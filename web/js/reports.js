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
        "bootstrap": 'http://netdna.bootstrapcdn.com/bootstrap/3.0.2/js/bootstrap.min'

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
        'bootstrap': {
            deps: ['jquery']
        }
    }
});

requirejs(["app/reports"]);