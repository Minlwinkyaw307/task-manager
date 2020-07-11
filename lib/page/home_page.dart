import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/page/task_detail_edit_page.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/global_data.dart';
import 'package:task_manager/util/global_method.dart';
import 'package:task_manager/widget/pie_chart_widget.dart';
import 'package:task_manager/widget/task_card_view_widget.dart';
import 'package:task_manager/widget/value_indicator.dart';
import 'package:vibration/vibration.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey _scaffoldKey = GlobalKey();
  PageController _pageController;
  TaskProvider _taskProvider;
  bool _shouldShowPie = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  Widget _topMenuBar(String title, int index) {
    bool active = index == _currentPage;
    double width = active ? 75 : 0;

    return GestureDetector(
      onTap: () {
        _currentPage = index;
        _pageController.jumpToPage(index);
      },
      child: Container(
        width: 75,
        child: Column(
          children: <Widget>[
            Container(
              width: 75,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            active
                ? Container(
                    margin: const EdgeInsets.only(
                      top: 7,
                    ),
                    width: width,
                    height: 3,
                    color: Colors.blue,
                  )
                : Container(),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  Widget _bottomSheetOptionTile(String title, Color textColor, IconData icon,
      Color iconColor, Function onPress) {
    return GestureDetector(
      child: ListTile(
        leading: Icon(
          icon,
          size: 27,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
        onTap: () => onPress(),
      ),
    );
  }

  void _longPressTaskCard(BuildContext context, Task task) {
    vibrate(150, 50);
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _bottomSheetOptionTile(
                    task.pinned ? "Unpin from top" : "Pin on top", Colors.black54, Icons.fiber_pin, Colors.black54, () {
                      print("PIN : ${task.pinned.toString()}");
                      task.pinned = task.pinned ? false: true;
                      print("PIN : ${task.pinned.toString()}");
                      _taskProvider.updateTask(task);
                  Navigator.of(context).pop();
                }),
                _bottomSheetOptionTile(
                    "Edit", Colors.blue, Icons.edit, Colors.blue, () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushNamed(TaskDetailEdit.ROUTE_NAME, arguments: task.id);
                }),
                _bottomSheetOptionTile(
                    task.status == "CANCELED" ? "Restore" : "Cancel",
                    Colors.amber,
                    task.status == "CANCELED" ? Icons.restore : Icons.cancel,
                    Colors.amber, () {
                      task.status = task.status == "CANCELED" ? "NEW" : "CANCELED";
                      _taskProvider.updateTask(task);
                  Navigator.of(context).pop();
                  //Navigator.of(context).pushNamed(TaskDetailEdit.ROUTE_NAME, arguments: task.id);
                }),
                _bottomSheetOptionTile(
                    "Delete", Colors.red, Icons.delete, Colors.red, () {
                  confirmAlertDialog(_scaffoldKey.currentContext, 'Confirm?',
                      "Are you sure, you want to delete this task?", () {
                    Navigator.of(context).pop();
                  }, () {
                    _taskProvider.deleteByID(task).then((result) {
                      if (result) {
                        Navigator.of(context).pop();
                      }
                    }).catchError((err) {
                      print(
                          "Getting Error while deleting a row(${task.id}) : ${err.toString()}");
                    });
                  });
                }),
              ],
            ),
          );
        });
  }

  Widget _taskListPageView(BuildContext context, BoxConstraints constraints,
      List<Task> sortedTasks) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      margin: const EdgeInsets.only(
        top: 15,
      ),
//      padding: EdgeInsets.only(
//        bottom: 50,
//      ),
      child: SingleChildScrollView(
        child: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight * 0.95,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: ListView.builder(
            itemCount: sortedTasks.length + 1,
            itemBuilder: (context, index) {
              if (sortedTasks.length == index)
                return SizedBox(
                  height: 60,
                );
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: InkWell(
                  onLongPress: () =>
                      _longPressTaskCard(context, sortedTasks[index]),
                  onTap: () {
                    Navigator.of(context).pushNamed(TaskDetailEdit.ROUTE_NAME,
                        arguments: sortedTasks[index].id);
                  },
                  child: TaskCardView(
                    currentTask: sortedTasks[index],
                    provider: _taskProvider,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this._taskProvider = Provider.of<TaskProvider>(context, listen: true);
    List<Task> currentTasks = [];
    if (_currentPage == 0)
      currentTasks = _taskProvider.getTodayTasks();
    else if (_currentPage == 1)
      currentTasks = _taskProvider.getThisWeekTasks();
    else if (_currentPage == 2)
      currentTasks = _taskProvider.getThisMonthTasks();
    else if (_currentPage == 3) currentTasks = _taskProvider.getAllTasks();

    return SafeArea(
      child: Scaffold(
          key: _scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(TaskDetailEdit.ROUTE_NAME, arguments: -1);
            },
            child: Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                _shouldShowPie = (constraints.maxHeight /
                        (PIE_ON_FOCUS_RADIUS * 2 +
                            PIE_MIDDLE_CIRCLE_RADIUS * 2) >=
                    4);
                return Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 10,
                          left: 16,
                          right: 16,
                        ),
                        child: Text(
                          "Hi, Min Lwin",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      _shouldShowPie
                          ? Container(
                              width: constraints.maxWidth,
                              height: PIE_ON_FOCUS_RADIUS * 2 +
                                  PIE_MIDDLE_CIRCLE_RADIUS * 2,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: PieChartWidget(
                                tasks: currentTasks,
                              )

//                    color: Colors.blue,
                              )
                          : SizedBox(
                              height: 20,
                            ),
                      Expanded(
                        child: Container(
                          width: constraints.maxWidth,
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            children: <Widget>[
                              NotificationListener<
                                  OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  // ignore: missing_return
                                  overscroll.disallowGlow();
                                  return false;
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _topMenuBar('Today', 0),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      _topMenuBar('Week', 1),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      _topMenuBar('Month', 2),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      _topMenuBar('All', 3),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,
                                      child: PageView(
                                        controller: _pageController,
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (pageNo) {
                                          setState(() {
                                            _currentPage = pageNo;
                                          });
                                        },
                                        children: <Widget>[
                                          _taskListPageView(
                                              context,
                                              constraints,
                                              _taskProvider.getTodayTasks()),
                                          _taskListPageView(
                                              context,
                                              constraints,
                                              _taskProvider.getThisWeekTasks()),
                                          _taskListPageView(
                                              context,
                                              constraints,
                                              _taskProvider
                                                  .getThisMonthTasks()),
                                          _taskListPageView(
                                              context,
                                              constraints,
                                              _taskProvider.getAllTasks()),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}
