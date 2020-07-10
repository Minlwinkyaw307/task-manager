import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../util/global_data.dart';

class PieChartWidget extends StatefulWidget {
  final double normal = 60;
  final double onPressed = 70;
  PieChartWidget();

  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.onPressed * 2.75 ,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  pieTouchResponse.touchInput is FlPanEnd) {
                touchedIndex = -1;
              } else {
                touchedIndex = pieTouchResponse.touchedSectionIndex;
              }
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          startDegreeOffset: 30,
          sectionsSpace: 3,
          centerSpaceRadius: 10,
          sections: showingSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? widget.onPressed : widget.normal;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: DONE_COLOR,
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: DOING_COLOR,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: CANCELED_COLOR,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
    /*
    if(widget.totalCaseAmount['total'] == 0) return [];

    print("Touched :  $touchedIndex");
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 13;
      final double radius = isTouched ? 90 : 80;
      final int total = widget.totalCaseAmount.containsKey('total') ? widget.totalCaseAmount['total'] : 0;
      switch (i) {
        case 0:
          int amount = widget.totalCaseAmount.containsKey('recovered') ? widget.totalCaseAmount['recovered'] : 0;
          double percent;
          if(widget.totalCaseAmount.containsKey('recovered') && widget.totalCaseAmount['recovered'] != 0)
            percent = amount / total * 100;
          else
            percent = 0.0;
          if(percent.isNaN) percent = 0.0;
          return PieChartSectionData(
            color: recoveredColor,
            value: amount.toDouble(),
            title: amount == 0
                ? ''
                : '${percent.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          int amount = widget.totalCaseAmount.containsKey('new') ? widget.totalCaseAmount['new'] : 0;
          double percent;
          if(widget.totalCaseAmount.containsKey('new') && widget.totalCaseAmount['new'] != 0)
            percent = amount / total * 100;
          else
            percent = 0.0;
          if(percent.isNaN) percent = 0.0;
          return PieChartSectionData(
            color: newColor,
            value: amount.toDouble(),
            title: amount == 0
                ? ''
                : '${percent.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          int amount = widget.totalCaseAmount.containsKey('serious') ? widget.totalCaseAmount['serious'] : 0;
          double percent;
          if(widget.totalCaseAmount.containsKey('serious') && widget.totalCaseAmount['serious'] != 0)
            percent = amount / total * 100;
          else
            percent = 0.0;
          if(percent.isNaN) percent = 0.0;
          return PieChartSectionData(
            color: seriousColor,
            value: amount.toDouble(),
            title: amount == 0
                ? ''
                : '${percent.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          int amount = widget.totalCaseAmount.containsKey('die') ? widget.totalCaseAmount['die'] : 0;
          double percent;
          if(widget.totalCaseAmount.containsKey('die') && widget.totalCaseAmount['die'] != 0)
            percent = amount / total * 100;
          else
            percent = 0.0;
          if(percent.isNaN) percent = 0.0;
          return PieChartSectionData(
            color: dieColor,
            value: amount.toDouble(),
            title: amount == 0
                ? ''
                : '${percent.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 4:
          int amount = widget.totalCaseAmount.containsKey('other') ? widget.totalCaseAmount['other'] : 0;
          double percent;
          if(widget.totalCaseAmount.containsKey('other') && widget.totalCaseAmount['other'] != 0)
            percent = amount / total * 100;
          else
            percent = 0.0;
          if(percent.isNaN) percent = 0.0;
          return PieChartSectionData(
            color: otherColor,
            value: amount.toDouble(),
            title: amount == 0
                ? ''
                : '${percent.toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
     */
  }
}
