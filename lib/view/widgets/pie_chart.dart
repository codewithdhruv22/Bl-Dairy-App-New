import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChart extends StatelessWidget {
  const PieChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    final List<ChartData> chartData = [
      ChartData('David', 25, Color.fromRGBO(9,0,136,1)),
      ChartData('Steve', 38, Color.fromRGBO(147,0,119,1)),
      ChartData('Jack', 34, Color.fromRGBO(228,0,124,1)),
      ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
    ];



    return SfCircularChart(

        series: <CircularSeries>[
          DoughnutSeries<ChartData, String>(

              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.x,
              yValueMapper: (ChartData data, _) => data.y,
              // Corner style of doughnut segment
              cornerStyle: CornerStyle.bothFlat
          )
        ]
    );
  }
}



class ChartData {
  ChartData(this.x, this.y,[ this.color = Colors.black]);
  final String x;
  final double y;
  final Color color;
}