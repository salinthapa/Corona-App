import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class TotalRecoveredChart extends StatelessWidget {
  final double totalRecovered;
  final double totalCase;

  TotalRecoveredChart({required this.totalCase, required this.totalRecovered});

  List<Color> pieColors = [Colors.blueGrey, Colors.blue];

  double calculate() {
    return (totalRecovered / totalCase) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: {
        "Recovered": totalRecovered,
        "Total Case": totalCase,
      },
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: pieColors,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      ringStrokeWidth: 32,
      centerText: "${calculate().toStringAsFixed(2)}%",
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: false,
        showChartValuesInPercentage: false,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
