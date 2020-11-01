import 'package:bloc_todo_login/bloc/bloc_class.dart';
import 'package:bloc_todo_login/bloc/bloc_events.dart';
import 'package:bloc_todo_login/bloc/bloc_states.dart';
import 'package:bloc_todo_login/ui/todo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<TaskBloc>(
      create: (context) {
        return TaskBloc(EmptyTasksState());
      },
      child: MaterialApp(
        home: App(),
      ),
    );
  }
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<TaskBloc>(context).add(GetAllTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TODOMainPage();
  }
}
