import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/page/task_detail_edit_page.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/global_data.dart';
import 'package:task_manager/widget/pie_chart_widget.dart';
import 'package:task_manager/widget/task_card_view_widget.dart';
import 'package:task_manager/widget/value_indicator.dart';

class HomePage extends StatefulWidget {
  static const ROUTE_NAME = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  TaskProvider _taskProvider;
  bool _shouldShowPie = false;
  int _currentPage = 0;


  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }
  Widget _topMenuBar(String title, int index){
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
            active ? Container(
              margin: const EdgeInsets.only(
                top: 7,
              ),
              width: width,
              height: 3,
              color: Colors.blue,
            ) : Container(),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  Widget _taskListPageView(BuildContext context, BoxConstraints constraints, List<Task> sortedTasks){
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight,
      margin: const EdgeInsets.only(
        top: 15,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: constraints.maxWidth,
          height:
          constraints.maxHeight * 0.95,
          margin: EdgeInsets.only(
            top: 10,
            bottom: 20,
          ),
          child: ListView.builder(
            itemCount: sortedTasks.length,
            itemBuilder:
                (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: TaskCardView(
                  currentTask:
                  sortedTasks[index],
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
    List<Task> allTasks = this._taskProvider.getListOfTasks();
    return SafeArea(
      child: Scaffold(
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
                _shouldShowPie = (constraints.maxHeight / (PIE_ON_FOCUS_RADIUS * 2 +  PIE_MIDDLE_CIRCLE_RADIUS * 2) >= 4);
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
                      _shouldShowPie ? Container(
                        width: constraints.maxWidth,
                        height: PIE_ON_FOCUS_RADIUS * 2 +  PIE_MIDDLE_CIRCLE_RADIUS * 2,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            PieChartWidget(),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  ValueIndicator(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ValueIndicator(),
                                ],
                              ),
                            )
                          ],
                        ),

//                    color: Colors.blue,
                      ) : SizedBox(height: 20,),
                      Expanded(
                        child: Container(
                          width: constraints.maxWidth,
                          padding: EdgeInsets.only(
                            top: 15,
                          ),
                          child: Column(
                            children: <Widget>[
                              NotificationListener<OverscrollIndicatorNotification>(
                                onNotification: (overscroll) {
                                  // ignore: missing_return
                                  overscroll.disallowGlow();
                                  return false;
                                },
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      _topMenuBar('Today', 0),
                                      SizedBox(width:20,),
                                      _topMenuBar('Week', 1),
                                      SizedBox(width:20,),
                                      _topMenuBar('Month', 2),
                                      SizedBox(width:20,),
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
                                          _taskListPageView(context, constraints, allTasks),
                                          _taskListPageView(context, constraints, [...allTasks, ...allTasks]),
                                          _taskListPageView(context, constraints, allTasks),
                                          _taskListPageView(context, constraints, allTasks),
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
