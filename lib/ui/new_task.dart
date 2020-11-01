import 'package:bloc_todo_login/bloc/bloc_class.dart';
import 'package:bloc_todo_login/bloc/bloc_events.dart';
import 'package:bloc_todo_login/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTask extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey();
  String taskName;
  String taskDescription;
  saveTaskName(String value) {
    this.taskName = value;
  }

  saveTaskDescription(String value) {
    this.taskDescription = value;
  }

  nullValidation(String value) {
    if (value == '') {
      return 'required field';
    }
  }

  saveTask(context) {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      BlocProvider.of<TaskBloc>(context).add(AddTaskEvent(Task(
          isComplete: false,
          taskDescription: taskDescription,
          taskName: taskName)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Container(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    onSaved: (newValue) => saveTaskName(newValue),
                    validator: (value) => nullValidation(value),
                    decoration: InputDecoration(
                        labelText: 'task title',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    onSaved: (newValue) => saveTaskDescription(newValue),
                    validator: (value) => nullValidation(value),
                    decoration: InputDecoration(
                        labelText: 'task Description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Add Task'),
                    onPressed: () {
                      saveTask(context);
                    })
              ],
            )),
      ),
    );
  }
}
