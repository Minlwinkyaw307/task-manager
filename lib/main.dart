import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/page/home_page.dart';
import 'package:task_manager/page/task_detail_edit_page.dart';
import 'package:task_manager/provider/task_provider.dart';
import 'package:task_manager/util/database_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DatabaseManager databaseManager;
  TaskProvider _taskProvider;

  @override
  void initState() {
    this.databaseManager = new DatabaseManager();
    _taskProvider = TaskProvider(databaseManager: this.databaseManager);
    this.databaseManager.init().then((bool value) {
      if (value) {
        this._taskProvider.init();
      } else {
        throw Exception("Couldn't Start Database");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _taskProvider),
      ],
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          fontFamily: 'QuickSand',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: HomePage.ROUTE_NAME,
        routes: {
          HomePage.ROUTE_NAME: (ctx) => HomePage(),
          TaskDetailEdit.ROUTE_NAME: (ctx) => TaskDetailEdit(),
        },
      ),
    );
  }
}
