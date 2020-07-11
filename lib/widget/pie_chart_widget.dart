import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/widget/value_indicator.dart';

import '../util/global_data.dart';

class PieChartWidget extends StatefulWidget {
  List<Task> tasks;
  int finishedTaskCount = 0;
  int newTaskCount = 0;
  int canceledTaskCount = 0;

  PieChartWidget({@required this.tasks}){
    this.tasks.forEach((element) {
      if(element.status == "NEW") this.newTaskCount++;
      else if(element.status == "DONE") this.finishedTaskCount++;
      else if(element.status == "CANCELED") this.canceledTaskCount++;
    });
  }


  @override
  _PieChartWidgetState createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    if(widget.tasks.length == 0) return SizedBox(
      width: double.infinity,
      height: 300,
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: PIE_ON_FOCUS_RADIUS * 2 +  PIE_MIDDLE_CIRCLE_RADIUS * 2,
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
              centerSpaceRadius: PIE_MIDDLE_CIRCLE_RADIUS,
              sections: showingSections(),
            ),
          ),
        ),
        SizedBox(width: 25,),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text('Total ${widget.tasks.length} Task(s)', style: TextStyle(
                  fontSize: 18,
                ),),

              ),
              SizedBox(
                height: 10,
              ),
              ValueIndicator(color: NEW_COLOR, title: 'New', count: widget.newTaskCount,),
              SizedBox(
                height: 10,
              ),
              ValueIndicator(color: DONE_COLOR, title: 'Done', count: widget.finishedTaskCount,),
              SizedBox(
                height: 10,
              ),
              ValueIndicator(color: CANCELED_COLOR, title: 'Canceled', count: widget.canceledTaskCount,),

            ],
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {

    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? PIE_ON_FOCUS_RADIUS : PIE_OUT_FOCUS_RADIUS;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: DONE_COLOR,
            value: widget.finishedTaskCount.toDouble(),
            title: widget.finishedTaskCount == 0 ? '' : '${(widget.finishedTaskCount/widget.tasks.length * 100).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: NEW_COLOR,
            value: widget.newTaskCount.toDouble(),
            title: widget.newTaskCount == 0 ? '' : '${(widget.newTaskCount/widget.tasks.length * 100).toStringAsFixed(0)}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: CANCELED_COLOR,
            value: widget.canceledTaskCount.toDouble(),
            title: widget.canceledTaskCount == 0 ? '':  '${(widget.canceledTaskCount/widget.tasks.length * 100).toStringAsFixed(0)}%',
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
