import 'package:bloc_todo_login/bloc/bloc_class.dart';
import 'package:bloc_todo_login/bloc/bloc_states.dart';
import 'package:bloc_todo_login/models/task_model.dart';
import 'package:bloc_todo_login/ui/new_task.dart';
import 'package:bloc_todo_login/ui/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TODOMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('TODO'),
          bottom: TabBar(tabs: [
            Tab(
              text: 'All Tasks',
            ),
            Tab(
              text: 'Complete Tasks',
            ),
            Tab(
              text: 'InComplete Tasks',
            )
          ]),
          actions: [
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return NewTask();
                  }));
                })
          ],
        ),
        body: TabBarView(children: [
          AllTasksTab(),
          CompleteTasksTab(),
          InCompleteTasksTab(),
        ]),
      ),
    );
  }
}

class AllTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TaskBloc, BlocStates>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmptyTasksState) {
          return Center(
            child: Text('Empty Tasks'),
          );
        } else if (state is TasksErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is TasksLoadedState) {
          List<Task> tasks = state.tasks;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskWidget(tasks[index]);
            },
          );
        }
      },
    );
  }
}

class CompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TaskBloc, BlocStates>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmptyTasksState) {
          return Center(
            child: Text('Empty Tasks'),
          );
        } else if (state is TasksErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is TasksLoadedState) {
          List<Task> allTasks = state.tasks;
          List<Task> tasks =
              allTasks.where((element) => element.isComplete == true).toList();
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskWidget(tasks[index]);
            },
          );
        }
      },
    );
  }
}

class InCompleteTasksTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<TaskBloc, BlocStates>(
      builder: (context, state) {
        if (state is TasksLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmptyTasksState) {
          return Center(
            child: Text('Empty Tasks'),
          );
        } else if (state is TasksErrorState) {
          return Center(
            child: Text(state.error),
          );
        } else if (state is TasksLoadedState) {
          List<Task> allTasks = state.tasks;
          List<Task> tasks =
              allTasks.where((element) => element.isComplete == false).toList();
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return TaskWidget(tasks[index]);
            },
          );
        }
      },
    );
  }
}
