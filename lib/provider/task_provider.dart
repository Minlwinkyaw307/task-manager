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
    @required DateTime startDate,
    @required DateTime endDate,
    @required TimeOfDay startTime,
    @required TimeOfDay endTime,
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
      });
      this._tasks[id] = task;
    }catch(e){
      print("Got Error while creating new task in provider");
      return false;
    }
    return true;

  }
}
