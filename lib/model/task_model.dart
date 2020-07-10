import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'dart:convert';


class Task {
  int id;
  String title;
  String description;
  String _startDate;
  String _endDate;
  String _startTime;
  String _endTime;

  DateTime get startDate {
    return DateTime.parse(this._startDate);
  }

  set startDate(DateTime dateTime) {
    this._startDate = dateTime.toString();
  }

  DateTime get endDate {
    return DateTime.parse(this._endDate);
  }

  set endDate(DateTime dateTime) {
    this._endDate = dateTime.toString();
  }


  TimeOfDay get startTime{
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(this._startTime));
  }

  set startTime(TimeOfDay startTime){
    this._startTime = startTime.toString();
  }

  TimeOfDay get endTime{
    final format = DateFormat.jm();
    return TimeOfDay.fromDateTime(format.parse(this._endTime));
  }

  set endTime(TimeOfDay startTime){
    this._endTime = startTime.toString();
  }


  static const String tableName = 'task';

  Task({
    @required this.id,
    @required this.title,
    @required this.description,
    @required DateTime startDate,
    @required DateTime endDate,
    @required TimeOfDay startTime,
    @required TimeOfDay endTime,
  }) {
    this.startDate = startDate;
    this.endDate = endDate;
    this.startTime = startTime;
    this.endTime = endTime;
  }

  Task.addNew(Database database, Map<String, dynamic> mapObj) {
    if (mapObj.containsKey('id') &&
        mapObj.containsKey('title') &&
        mapObj.containsKey('description') &&
        mapObj.containsKey('startDate') &&
        mapObj.containsKey('endDate') &&
        mapObj.containsKey('startTime') &&
        mapObj.containsKey('endTime')) {
      this.id = mapObj['id'];
      this.title = mapObj['title'];
      this.description = mapObj['description'];
      this.startDate = mapObj['startDate'];
      this.endDate = mapObj['endDate'];
      this.startTime = mapObj['startTime'];
      this.endTime = mapObj['endTime'];
      database.execute(createTableString()).then((_) {
        database.rawInsert(this.replaceDBString(), [
          this.id,
          this.title,
          this.description,
          this.startDate.toString(),
          this.endDate.toString(),
          this.startTime.toString(),
          this.endTime.toString(),
        ]);
      }).then((id) {
//        this.id = id;
        print("Task {$id} has created");
      }).catchError((onError) {
        this.id = 0;
       print("Catch Error While Creating New Task Object : " +
            onError.toString());
      });
    } else {
      this.id = 0;
      print("Required Values Didn't Include");
    }
  }

  Future<bool> retrieveFromDatabase(Database database, id) async {
    try {
      List<Map<String, dynamic>> resultList =
      database.query(Task.tableName, where: 'id = ?', whereArgs: [id])
      as List<Map<String, dynamic>>;
      if (resultList.length > 0) {
        var result = resultList[0];
        this.id = result['id'];
        return true;
      }
      return false;
    } catch (error) {
      this.id = 0;
      print(
          "Getting Error while retrieving Task Object From DB $id : " +
              error.toString());
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> retrieveAll(
      Database database) async {
    return await database.query(
      Task.tableName,
    );
  }

  static Future<List<Task>> retrieveAllAsList(Database database) async {
    List<Map<String, dynamic>> tempResult = await retrieveAll(database);
    List<Task> returnList = [];
    for (int i = 0; i < tempResult.length; i++) {
      var temp = tempResult[i];
      returnList.add(new Task(
        id: temp['id'],
        title: temp['title'],
        description: temp['thumbnail'],
        startDate: temp['startDate'],
        endDate: temp['endDate'],
        startTime: temp['startTime'],
        endTime: temp['endTime'],
      ));
    }
    return returnList;
  }

  String createTableString() {
    return 'CREATE TABLE IF NOT EXISTS ${Task.tableName} ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title TEXT, '
        'description TEXT, '
        'startDate TEXT, '
        'endDate TEXT, '
        'startTime TEXT, '
        'endTime TEXT)';
  }

  String replaceDBString() {
    return 'REPLACE INTO ${Task.tableName} (id, title, description, startDate, endDate, startTime, endTime) VALUES (?, ?, ?, ?, ?, ?, ?)';
  }

  static Future<bool> dropDB(Database database) async {
    try {
      await database.rawQuery(Task.deleteTableString());
      return true;
    } catch (error) {
      return false;
    }
  }

  static String deleteTableString() {
    return 'DROP TABLE IF EXISTS ${Task.tableName}';
  }
}
