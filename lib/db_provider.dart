import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'models.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

//actually create db on init
  initDB() async {
    var db_path = await getDatabasesPath();
    String path = join(db_path, "todo.db");
    return await openDatabase(path, version: 4, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      print("creating db");
      await db.execute("CREATE TABLE TodoList ("
          "id INTEGER PRIMARY KEY AUTOINCREMENT,"
          "name TEXT,"
          "status TEXT," //set as text for convenience
          "progress TEXT,"
          "createDate TEXT,"
          "finishDate TEXT,"
          "startDate TEXT,"
          "deadLine TEXT,"
          "details TEXT,"
          ")");
    });
  }

  //this is so good
  Future createTask(Task task) async {
    final db = await database;
    task.id = await db.insert("TodoList", task.toMap());
  }

  //can fetch tasks for any day and filter by their status of done or not done
  //what if i wanted to fetch all for a day?
  Future<List<Task>> getTasks({DateTime deadlineDate, String status}) async {
    final db = await database;

    //some magic to handle dates to string
    String deadlineDate_str = deadlineDate.toString() ?? "*";

    //filtering for here is ugly for now (need to focus here)

    var list = await db.query("TodoList",
        where: "status = ? and deadlineDate=?",
        whereArgs: [status ?? "*", deadlineDate_str]);

    List<Task> tasks = [];
    tasks.clear();
    tasks.addAll(Task.fromMapList(list));
    return tasks;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await database;

    //fetch everything
    var list = await db.query("TodoList", where: "status=?", whereArgs: ["*"]);

    List<Task> tasks = [];
    tasks.clear();
    tasks.addAll(Task.fromMapList(list));
    return tasks;
  }
}
