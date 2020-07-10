import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/util/global_data.dart';

class TaskCardView extends StatelessWidget {
  final Task currentTask;
  Color _bgColor;
  Color _leftLineColor;

  TaskCardView({@required this.currentTask});

  @override
  Widget build(BuildContext context) {
    double cartheight = 120;
    if (this.currentTask.status == 'NEW') {
      _bgColor = Colors.lightBlue[50];
      _leftLineColor = Colors.lightBlue[300];

      _bgColor = Colors.yellow[50];
      _leftLineColor = Colors.yellow[300];

      _bgColor = Colors.red[50];
      _leftLineColor = Colors.red[300];
    }

    final dateFormat = new DateFormat('dd.MM.yyyy');
//    return Container(
//      color: _bgColor,
//      margin: EdgeInsets.only(
//        bottom: 7,
//      ),
//      height: cartheight,
//      child: Row(
//        children: <Widget>[
//          Container(
//            height: cartheight,
//            width: 5,
//            color: _leftLineColor,
//          ),
//          SizedBox(
//            width: 20,
//          ),
//          Expanded(
//            child: Container(
//              child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  Text(
//                    dateFormat.format(currentTask.startDate),
//                    style: TextStyle(
//                        fontSize: 12, fontWeight: FontWeight.normal),
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(
//                      bottom: 10
//                    ),
//                    child: Text(
//                      currentTask.title,
//                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                    ),
//                  ),
//                  Text(
//                    currentTask.startTime.format(context) + " - " + currentTask.endTime.format(context),
//                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black54),
//                  ),
//
//                ],
//              ),
//            ),
//          )
//        ],
//      ),
//    );
    return Opacity(
      opacity: 1,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 5,
        ),
        margin: EdgeInsets.only(
          bottom: 15,
        ),
        decoration: BoxDecoration(
            color: Color(0xFFF2D7D5),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: -7.5,
                blurRadius: 20,
                offset: Offset(0, 5),
              ),
            ]),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x23000000),
                    width: 0.3,
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 5,
              ),
              child: Row(
                children: <Widget>[
//                  Expanded(
//                      flex: 3,
//                      child: Padding(
//                        padding: EdgeInsets.only(
//                          left: 15,
//                        ),
//                        child: Align(
//                          alignment: Alignment.centerLeft,
//                          child: Container(
//                            width: 15,
//                            height: 15,
//                            decoration: BoxDecoration(
//                                color: DONE_COLOR,
//                                borderRadius: BorderRadius.circular(100)),
//                          ),
//                        ),
//                      )),
                  Expanded(
                    flex: 17,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            child: Text(
                              currentTask.title,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            dateFormat.format(currentTask.startDate),
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 15,
                ),
                child: Text(
                  currentTask.description.toString(),
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0x23000000),
                    width: 0.3,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: 5
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 14,
                    child: Container(
                      child: Text("${currentTask.startTime.format(context)} - ${currentTask.endTime.format(context)}"),
                    ),
                  ),
//                  Expanded(
//                    flex: 3,
//                    child: Container(
//                      child: Icon(
//                        Icons
//                            .mode_edit,
//                        size: 25,
//                        color: Colors.lightBlue,
//                      ),
//                    ),
//                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Text(
                        "Done",
                        style: TextStyle(
                          color: CANCELED_COLOR,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
//                      Icon(
//                        Icons
//                            .delete,
//                        size: 25,
//                        color: CANCELED_COLOR,
//                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
