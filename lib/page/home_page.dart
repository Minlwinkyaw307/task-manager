import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:task_manager/widget/task_list_page_view.dart';

import '../model/task_model.dart';
import '../page/task_detail_edit_page.dart';
import '../provider/task_provider.dart';
import '../util/global_data.dart';
import '../widget/pie_chart_widget.dart';

class HomePage extends StatefulWidget {
  // Home Page route name
  static const ROUTE_NAME = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //page view controller
  PageController _pageController;

  //task provider to retrieve, update and add new task
  TaskProvider _taskProvider;

  //check status of showing pie or not
  bool _shouldShowPie = false;

  //current page index in page view
  int _currentPage = 0;

  //to show mobile layout or tablet layout
  bool _isMobile;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  //Top task date widget
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

  // get welcome message like morning, evening
  String _getWelcomeMessage() {
    String welcomeMessage = "";
    TimeOfDay now = TimeOfDay.now();
    if (now.hour >= 5 && now.hour <= 12)
      return 'Hello, Good Morning';
    else if (now.hour > 12 && now.hour <= 5) return 'Hello, Good Afternoon';
    return 'Hello, Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    //getting task provider
    this._taskProvider = Provider.of<TaskProvider>(context, listen: true);

    // checking device is mobile or tablet
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    _isMobile = shortestSide < 600;

    // getting current tasks to show them in pie chart
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // route to add new task (id must be -1 to confirm new task or edit task)
              Navigator.of(context)
                  .pushNamed(TaskDetailEdit.ROUTE_NAME, arguments: -1);
            },
            child: Icon(Icons.add),
          ),
          body: LayoutBuilder(
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
                        _getWelcomeMessage(),
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
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: this._isMobile ? 0 : 16,
                                          ),
                                          child: TaskListPageView(
                                            constraints: constraints,
                                            isMobile: _isMobile,
                                            sortedTasks: _taskProvider.getTodayTasks(),
                                            taskProvider: _taskProvider,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: this._isMobile ? 0 : 16,
                                          ),
                                          child: TaskListPageView(
                                            constraints: constraints,
                                            isMobile: _isMobile,
                                            sortedTasks: _taskProvider.getThisWeekTasks(),
                                            taskProvider: _taskProvider,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: this._isMobile ? 0 : 16,
                                          ),
                                          child: TaskListPageView(
                                            constraints: constraints,
                                            isMobile: _isMobile,
                                            sortedTasks: _taskProvider.getThisMonthTasks(),
                                            taskProvider: _taskProvider,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: this._isMobile ? 0 : 16,
                                          ),
                                          child: TaskListPageView(
                                            constraints: constraints,
                                            isMobile: _isMobile,
                                            sortedTasks: _taskProvider.getAllTasks(),
                                            taskProvider: _taskProvider,
                                          ),
                                        ),
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
          )),
    );
  }
}
