import 'dart:io';

import 'package:bloc_todo_login/models/task_model.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  var logger = Logger();
  Database database;
  String databaseName = 'tasks.db';
  static final String taskTableName = 'tasks';
  static final String taskIdColumnName = 'taskId';
  static final String taskNameColumnName = 'taskName';
  static final String taskDescriptionColumnName = 'taskDesc';
  static final String taskIsCompleteColumnName = 'taskIsComplete';
  Future<Database> initDatabase() async {
    if (database == null) {
      return openDataBase();
    } else {
      return database;
    }
  }

  Future<Database> openDataBase() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      String dbPath = join(appDocPath, databaseName);
      Database database = await openDatabase(dbPath, version: 1,
          onCreate: (Database db, int version) async {
        await createTasksTable(db);
      });
      return database;
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  createTasksTable(Database db) async {
    db.execute('''CREATE TABLE $taskTableName(
      $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
      $taskNameColumnName TEXT NOT NULL,
      $taskDescriptionColumnName TEXT,
      $taskIsCompleteColumnName INTEGER
    )''');
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int rowNumber = await database.insert(taskTableName, task.toMap());
      logger.i(rowNumber.toString());
    } on Exception catch (e) {
      logger.e(e);
    }
  }

  Future<List<Task>> getAllTasks() async {
    try {
      database = await initDatabase();
      List<Map<String, dynamic>> response = await database.query(taskTableName);
      List<Task> allTasks = response.map((e) => Task.fromMap(e)).toList();
      return allTasks;
    } on Exception catch (e) {
      logger.e(e);
      return null;
    }
  }

  deleteTask(Task task) async {
    try {
      database = await initDatabase();
      int deletedRowsCount = await database.delete(taskTableName,
          where: '$taskIdColumnName = ?', whereArgs: [task.id]);
      logger.i(deletedRowsCount.toString());
    } catch (error) {
      logger.e(error);
    }
  }

  updateTask(Task task) async {
    try {
      database = await initDatabase();
      int updatedRowsCount = await database.update(taskTableName, task.toMap(),
          where: '$taskIdColumnName = ?', whereArgs: [task.id]);
      logger.i(updatedRowsCount.toString());
    } catch (error) {
      logger.e(error);
    }
  }
}
