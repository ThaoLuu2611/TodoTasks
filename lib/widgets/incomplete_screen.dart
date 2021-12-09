import 'package:flutter/material.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/widgets/to_do_item.dart';

class IncompleteScreen extends StatefulWidget {
  var bloc = TodoBloc();
  IncompleteScreen({Key? key, required this.bloc}) : super(key: key);

  @override
  _IncompleteScreenState createState() => _IncompleteScreenState();
}

class _IncompleteScreenState extends State<IncompleteScreen> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getIncompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: widget.bloc.inCompletedTaskStream,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: widget.bloc.listIncompletedTasks.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todoItem: widget.bloc.listIncompletedTasks[index],
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
