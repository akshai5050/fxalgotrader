var fat;
define(['jquery','require', 'app/reports_socketwrapper', 'app/report_chart', 'app/profit_chart'], function ($, require, ReportsSocketWrapper, ReportChart, ProfitChart) {


    //Do setup work here
    "use strict";



    $('#myModal').on('show.bs.modal', function() {
        $('#daily_chart').css('visibility', 'hidden');
    });

    $('#myModal').on('shown.bs.modal', function () {
        $('#daily_chart').css('visibility', 'initial');
        var chart = $('#daily_chart').highcharts();
        chart.reflow();

    })



    var reportsSocketWrapper = new ReportsSocketWrapper(4321);
    reportsSocketWrapper.openConnection();

    var reportChart = new ReportChart(new Array());
    alert($(document));

    $(document).on('click', ".report-btn", function(){
        var chart = $('#daily_chart').highcharts();
        if (chart != undefined) {
            chart.destroy();
        }
        drawChart(this.id);


    });

    $(document).on('click', ".report-profit-btn", function(){
        var chart = $('#daily_chart').highcharts();
        if (chart != undefined) {
            chart.destroy();
        }
        drawProfitsChart(this.id);

        $('.modal').each(function(){
            var modalWidth = $(this).width(),
                modalMargin = '-' + (modalWidth/2) + 'px!important';
            $(this).css('margin-left',modalMargin);
        });
    });

    function drawChart(id) {
        var hashed_data = days_hashmap[id];
        var arr = new Array();

        for (var i = 0; i < hashed_data.length; i++) {
            var array_values = new Array();
            for (var key in hashed_data[i]) {
                if (key == "start_dt") {
                    array_values.push(hashed_data[i][key]*1000);
                } else {
                    array_values.push(hashed_data[i][key]);
                }

            }
            arr.push(array_values);
        }
        new ReportChart(arr, id);
        $(".modal-title").text("OHLC Chart");

    }

    function drawProfitsChart(id) {
        var hashed_data = days_profit_hashmap[id];
        var arr = new Array();

        for (var i = 0; i < hashed_data.length; i++) {
            var array_values = new Array();
            for (var key in hashed_data[i]) {
                if (key == "dt") {
                        array_values.push(new Date(hashed_data[i][key]*1000).getTime());
                    console.log("Adding " + new Date(hashed_data[i][key]*1000));
                } else {
                    array_values.push(hashed_data[i][key]);
                }

            }
            arr.push(array_values);

        }
        fat = arr;
        new ProfitChart(arr, id);
        $(".modal-title").text("Profit Chart");

    }




});

