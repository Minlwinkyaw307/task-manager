import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/global_data.dart';

class TaskCardView extends StatelessWidget {
  final Task currentTask;
  final TaskProvider provider;
  Color _bgColor;
  Color _leftLineColor;

  TaskCardView({@required this.currentTask, @required this.provider});

  @override
  Widget build(BuildContext context) {
    if (this.currentTask.status == 'NEW')
      _bgColor = NEW_COLOR_SEC;
    else if (this.currentTask.status == 'DONE')
      _bgColor = DONE_COLOR_SEC;
    else if (this.currentTask.status == 'CANCELED')
      _bgColor = CANCELED_COLOR_SEC;

    final dateFormat = new DateFormat('dd.MM.yyyy');
//        return Container(
//      width: double.infinity,
//      height: 100,
//      color: Colors.blue,
//      child: Material(
//        color: Colors.transparent,
//        child: Ink(
//          decoration: BoxDecoration(
//            // ...
//          ),
//          child: InkWell(
//            onTap: () {}, //other widget
//          ),
//        ),
//      ),
//    );

    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      decoration: BoxDecoration(
        color: _bgColor,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Column(
        children: <Widget>[
          Material(
            type: MaterialType.transparency,
            elevation: 6.0,
            color: Colors.transparent,
            shadowColor: Colors.grey[50],
            child: Ink(
              child: InkWell(
                onTap: (){},
                child: Wrap(
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
                      padding: EdgeInsets.only(
                        top: 15,
                        bottom: 5,
                      ),
                      child: Row(
                        children: <Widget>[
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
                                      "${currentTask.pinned ? '📌 ' : ""}${currentTask.title}",
                                      textAlign: TextAlign.justify,
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
                          currentTask.description.split(' ').length > 25
                              ? currentTask.description
                              .split(' ')
                              .sublist(0, 25)
                              .join(' ') +
                              "..."
                              : currentTask.description,
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
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentTask.status != 'DONE') {
                currentTask.status = "DONE";
              } else {
                currentTask.status = "NEW";
              }
              provider.updateTask(currentTask).then((result) {
                if (result) print("Successfully Updated");
              }).catchError((err) {
                print(
                    "Getting Error While Update status : ${err.toString()}");
              });
            },
            child: Container(
              padding:
              const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 14,
                    child: Container(
                      child: Text(
                          "${currentTask.startTime.format(context)} - ${currentTask.endTime.format(context)}"),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Text(
                        currentTask.status == 'DONE'
                            ? "UNDONE"
                            : currentTask.status == 'CANCELED' ? "" : "DONE",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
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
            ),
          )
        ],
      ),


    );
  }
}
