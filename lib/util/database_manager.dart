import 'package:sqflite/sqflite.dart';

class DatabaseManager{
  Database database;
  String dbBasePath;
  String dbFileName;
  String dbPath;
  int dbVersion;

  DatabaseManager({
    this.dbBasePath,
    this.dbFileName = 'task_manager.db',
    this.dbVersion = 1,
  });

  Future<bool> init() async{
    try{
      if(this.database == null){
        this.dbBasePath = await getDatabasesPath();
        this.dbPath = this.dbBasePath + this.dbFileName;
        this.database = await openDatabase(this.dbPath, version: this.dbVersion);
        print("Database Has Opened : " + database.toString());
      }

      return true;
    }catch(error){
      print("Getting Error while opening Database : " + error.toString());
      return false;
    }
  }
}