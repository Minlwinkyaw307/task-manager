import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/page/task_detail_edit_page.dart';
import 'package:task_manager/provider/task_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
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
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight * 0.235,
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
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Today",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 7,
                                          ),
                                          width: 75,
                                          height: 3,
                                          color: Colors.blue,
                                        )
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Week",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 7,
                                          ),
                                          width: 75,
                                          height: 3,
                                          color: Colors.blue,
                                        )
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 20,
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Month",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                            top: 7,
                                          ),
                                          width: 75,
                                          height: 3,
                                          color: Colors.blue,
                                        )
                                      ],
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return Container(
                                      width: constraints.maxWidth,
                                      height: constraints.maxHeight,

                                      child: PageView(
                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (pageNo) {
                                          print("Page Number " +
                                              pageNo.toString());
                                        },
                                        children: <Widget>[
                                          Container(
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
                                                  itemCount: this
                                                      ._taskProvider
                                                      .allTaskCount(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Container(
                                                      padding: const EdgeInsets.symmetric(
                                                        horizontal: 16,
                                                      ),
                                                      child: TaskCardView(
                                                        currentTask:
                                                            allTasks[index],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
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
            ),
          )),
    );
  }
}
