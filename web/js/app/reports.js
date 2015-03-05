define(['jquery','require', 'app/reports_socketwrapper', 'app/report_chart'], function ($, require, ReportsSocketWrapper, ReportChart) {


    //Do setup work here
    "use strict";



    $('#myModal').on('show.bs.modal', function() {
        $('#daily_chart').css('visibility', 'hidden');
        console.log("Opened modal");
    });
    $('#myModal').on('shown.bs.modal', function() {

        $('#daily_chart').css('visibility', 'initial');
        var chart = $('#daily_chart').highcharts();
        chart.reflow();

    });



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
        console.log(arr.length);
        console.log(arr);
        new ReportChart(arr);
    }




});

