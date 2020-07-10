import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:task_manager/model/task_model.dart';
import 'package:task_manager/util/database_manager.dart';

class TaskProvider with ChangeNotifier {
  DatabaseManager databaseManager;
  Map<int, Task> _tasks = new Map<int, Task>();

  TaskProvider({
    @required this.databaseManager,
  });

  Future<bool> init() async {
    try {
      await this.databaseManager.database.execute(Task.createTableString());
      await retrieveAndUpdateTasks();
      return true;
    } catch (error) {
      print("Getting Error while opening Database : " + error.toString());
      return false;
    }
  }

  Future<bool> retrieveAndUpdateTasks() async {
    try {
      if (this.databaseManager.database == null)
        throw Exception("Database is Null");
      List<Task> tempTasks =
          await Task.retrieveAllAsList(this.databaseManager.database);
      tempTasks.forEach((element) {
        this._tasks[element.id] = element;
      });

      notifyListeners();
      return true;
    } catch (error) {
      print(
          'Getting Error while Retrieving Data For Task : ' + error.toString());
      return false;
    }
  }

  int allTaskCount(){
    return this._tasks.length;
  }

  List<Task> getListOfTasks() {
    List<Task> returnList = [];
    this._tasks.forEach((id, element) {
      returnList.add(element);
    });
    return returnList;
  }

  Task getTaskByID(int id) {
    return this._tasks[id];
  }

  bool isIDExist(int id) {
    return this._tasks.containsKey(id);
  }

  bool addNewTask ({
    @required String title,
    @required String description,
    @required String startDate,
    @required String endDate,
    @required String startTime,
    @required String endTime,
    @required String status
  }){
    try{
      int id = new Random().nextInt(100000);

      Task task = Task.addNew(this.databaseManager.database, {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'status': status,
      });
      this._tasks[id] = task;
      print(task.description);
      notifyListeners();
    }catch(e){
      print("Got Error while creating new task in provider : " + e.toString());
      return false;
    }
    return true;

  }
}
