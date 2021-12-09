import 'package:flutter/material.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/widgets/to_do_item.dart';

class AllTasksScreen extends StatefulWidget {
  var bloc = TodoBloc();

  AllTasksScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  _AllTasksScreenState createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.bloc.allTodoTaskStream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: widget.bloc.listAllTasks.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todoItem: widget.bloc.listAllTasks[index],
                bloc: widget.bloc,
              );
            },
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
