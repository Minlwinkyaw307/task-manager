import 'package:flutter/material.dart';
import 'package:task_manager/page/home_page.dart';
import 'package:task_manager/page/task_detail_edit_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TaskDetailEdit(),
    );
  }
}
