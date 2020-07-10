import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: Icon(
            Icons.add
          ),
        ),
          body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
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
//                  Text(
//                    "Today your task list",
//                    style: TextStyle(
//                      color: Color.fromRGBO(0, 0, 0, 0.75),
//                      fontSize: 15,
//                      fontWeight: FontWeight.w300,
//                    ),
//                  ),

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
                                  padding: EdgeInsets.only(top: 15, bottom: 15),
                                  child: PageView(
                                    scrollDirection: Axis.horizontal,
                                    onPageChanged: (pageNo) {
                                      print("Page Number " + pageNo.toString());
                                    },
                                    children: <Widget>[
                                      Container(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                TaskCardView(),
                                                TaskCardView(),
                                                TaskCardView(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                TaskCardView(),
                                                TaskCardView(),
                                                TaskCardView(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: constraints.maxWidth,
                                        height: constraints.maxHeight,
                                        padding: const EdgeInsets.only(
                                          top: 15,
                                        ),
                                        child: SingleChildScrollView(
                                          child: Container(
                                            child: Column(
                                              children: <Widget>[
                                                TaskCardView(),
                                                TaskCardView(),
                                                TaskCardView(),
                                              ],
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
