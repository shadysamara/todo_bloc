import 'package:bloc_todo_login/bloc/bloc_class.dart';
import 'package:bloc_todo_login/bloc/bloc_events.dart';
import 'package:bloc_todo_login/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskWidget extends StatelessWidget {
  Task task;
  TaskWidget(this.task);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: ListTile(
        title: Text(task.taskName),
        subtitle: Text(task.taskDescription),
        trailing: Checkbox(
          value: task.isComplete,
          onChanged: (value) {
            BlocProvider.of<TaskBloc>(context).add(UpdateTaskEvent(task));
          },
        ),
        leading: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<TaskBloc>(context).add(DeleteTaskEvent(task));
            }),
      ),
    );
  }
}
