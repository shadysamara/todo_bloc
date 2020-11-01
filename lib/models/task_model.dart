import 'package:bloc_todo_login/services/database_helper.dart';

class Task {
  int id;
  String taskName;
  String taskDescription;
  bool isComplete;
  Task({this.isComplete, this.taskDescription, this.taskName});
  Task.fromMap(Map map) {
    this.id = map[DBHelper.taskIdColumnName];
    this.taskName = map[DBHelper.taskNameColumnName];
    this.taskDescription = map[DBHelper.taskDescriptionColumnName];
    this.isComplete =
        map[DBHelper.taskIsCompleteColumnName] == 1 ? true : false;
  }
  Map<String, dynamic> toMap() {
    return {
      DBHelper.taskNameColumnName: this.taskName,
      DBHelper.taskDescriptionColumnName: this.taskDescription,
      DBHelper.taskIsCompleteColumnName: this.isComplete ? 1 : 0,
    };
  }
}
