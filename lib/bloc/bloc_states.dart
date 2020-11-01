import 'package:bloc_todo_login/models/task_model.dart';

abstract class BlocStates {
  const BlocStates();
}

class TasksLoadingState extends BlocStates {}

class TasksLoadedState extends BlocStates {
  List<Task> tasks;
  TasksLoadedState(this.tasks);
}

class TasksErrorState extends BlocStates {
  String error;
  TasksErrorState(this.error);
}

class EmptyTasksState extends BlocStates {}

class TaskSelectedState extends BlocStates {
  Task task;
  TaskSelectedState(this.task);
}
