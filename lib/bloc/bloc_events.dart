import 'package:bloc_todo_login/models/task_model.dart';

abstract class BlocEvents {
  const BlocEvents();
}

class AddTaskEvent extends BlocEvents {
  Task task;
  AddTaskEvent(this.task);
}

class GetAllTasksEvent extends BlocEvents {}

class DeleteTaskEvent extends BlocEvents {
  Task task;
  DeleteTaskEvent(this.task);
}

class UpdateTaskEvent extends BlocEvents {
  Task task;
  UpdateTaskEvent(this.task);
}
