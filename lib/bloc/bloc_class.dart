import 'package:bloc/bloc.dart';
import 'package:bloc_todo_login/bloc/bloc_events.dart';
import 'package:bloc_todo_login/bloc/bloc_states.dart';
import 'package:bloc_todo_login/models/task_model.dart';
import 'package:bloc_todo_login/services/database_helper.dart';

class TaskBloc extends Bloc<BlocEvents, BlocStates> {
  TaskBloc(BlocStates initialState) : super(initialState);
  List<Task> allTasks;
  Future<List<Task>> getAllTasks() async {
    if (allTasks == null) {
      List<Task> tasks = await DBHelper.dbHelper.getAllTasks();
      allTasks = tasks;
      return tasks;
    } else {
      return allTasks;
    }
  }

  @override
  Stream<BlocStates> mapEventToState(BlocEvents event) async* {
    if (event is GetAllTasksEvent) {
      yield TasksLoadingState();
      List<Task> tasks = await getAllTasks();
      if (tasks.isEmpty) {
        yield EmptyTasksState();
      } else {
        yield TasksLoadedState(tasks);
      }
    }
    ////////////////////////////////////////////////////////////////////
    if (event is AddTaskEvent) {
      try {
        yield TasksLoadingState();
        await DBHelper.dbHelper.insertNewTask(event.task);
        List<Task> tasks = await DBHelper.dbHelper.getAllTasks();
        yield TasksLoadedState(tasks);
      } catch (e) {
        yield TasksErrorState(e.toString()); // TODO
      }
    }
    ////////////////////////////////////////////////////////////////////
    if (event is DeleteTaskEvent) {
      try {
        yield TasksLoadingState();
        await DBHelper.dbHelper.deleteTask(event.task);
        List<Task> tasks = await DBHelper.dbHelper.getAllTasks();
        yield TasksLoadedState(tasks);
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
    ///////////////////////////////////////////////////////////////////
    if (event is UpdateTaskEvent) {
      try {
        yield TasksLoadingState();
        event.task.isComplete = !event.task.isComplete;
        await DBHelper.dbHelper.updateTask(event.task);
        List<Task> tasks = await DBHelper.dbHelper.getAllTasks();
        yield TasksLoadedState(tasks);
      } catch (e) {
        yield TasksErrorState(e.toString());
      }
    }
  }
}
