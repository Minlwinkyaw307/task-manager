import 'dart:convert';
import 'dart:io';
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

  int allTaskCount() {
    return this._tasks.length;
  }

  List<Task> _sortTask(List<Task> unsortedTask){
    unsortedTask.sort((a, b) => a.startDate.compareTo(b.startDate));
    unsortedTask.sort((a, b) => ((b.startTime.hour * 60 + b.startTime.minute) - (a.startTime.hour * 60 + a.startTime.minute)));
    unsortedTask.sort((a, b) {
      int _a = a.pinned  ? 1 : 0;
      int _b = b.pinned  ? 1 : 0;
      return _b - _a;
    });

    return unsortedTask;
  }

  List<Task> getAllTasks() {
    List<Task> returnList = [];
    this._tasks.forEach((id, element) {
      returnList.add(element);
    });
    return _sortTask(returnList);
  }

  List<Task> getTodayTasks(){
    List<Task> returnList = [];
    this._tasks.forEach((id, element) {
      if(element.startDate.difference(DateTime.now()).inDays == 0 && element.startDate.day == DateTime.now().day)
        returnList.add(element);
    });
    return _sortTask(returnList);
  }

  List<Task> getThisWeekTasks(){
    List<Task> returnList = [];
    this._tasks.forEach((id, element) {
      int diff = element.startDate.difference(DateTime.now()).inDays;
      if(diff >= 0 && diff <= 6)
        returnList.add(element);
    });
    return _sortTask(returnList);
  }

  List<Task> getThisMonthTasks(){
    List<Task> returnList = [];
    this._tasks.forEach((id, element) {
      int diff = element.startDate.difference(DateTime.now()).inDays;
      if(diff >= 0 && diff <= 30)
        returnList.add(element);
    });
    return _sortTask(returnList);
  }

  Task getTaskByID(int id) {
    return this._tasks[id];
  }

  bool isIDExist(int id) {
    return this._tasks.containsKey(id);
  }

  Future<bool> deleteByID(Task task) async{
    this._tasks.remove(task.id);
    notifyListeners();
    Task.deleteByID(this.databaseManager.database, task.id);
    return true;
  }

  Future<bool> updateTask(Task task) async{
    return await addNewTask(
      id: task.id,
      title: task.title,
      description: task.description,
      startDate: task.startDate.toString(),
      endDate: task.endDate.toString(),
      startTime: task.startTimeString,
      endTime: task.endTimeString,
      status: task.status,
      pinned: task.pinned,
    );
  }

  Future<bool> addNewTask({
    @required String title,
    @required String description,
    @required String startDate,
    @required String endDate,
    @required String startTime,
    @required String endTime,
    @required String status,
    @required bool pinned,
    int id = -1,
  }) async{
    try {
      if (id == -1) id = new Random().nextInt(100000);
      Task task = Task.addNew(this.databaseManager.database, {
        'id': id,
        'title': title,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'startTime': startTime,
        'endTime': endTime,
        'status': status,
        'pinned': pinned,
      });
      this._tasks[id] = task;
      notifyListeners();
//      _updateList();
    } catch (e) {
      print("Got Error while creating new task in provider : " + e.toString());
      return false;
    }
    return true;
  }

  Future<void> _updateList() async{
    try{
      List<Task> tasks = await Task.retrieveAllAsList(this.databaseManager.database);
      this._tasks.clear();
      tasks.forEach((element) {
        this._tasks[element.id] = element;
      });
      notifyListeners();
      print("notified");
    }catch(err){
      print("Got Error while retrieving all task in provider : " + e.toString());
    }
  }


}
