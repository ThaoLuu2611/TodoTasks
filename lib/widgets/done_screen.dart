import 'package:flutter/material.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/widgets/to_do_item.dart';

class DoneScreen extends StatefulWidget {
  var bloc = TodoBloc();

  DoneScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  _DoneScreenState createState() => _DoneScreenState();
}

class _DoneScreenState extends State<DoneScreen> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.bloc.completedTasksStream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: widget.bloc.listCompletedTasks.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todoItem: widget.bloc.listCompletedTasks[index],
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
