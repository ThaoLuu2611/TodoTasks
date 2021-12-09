import 'package:flutter/material.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/models/todo.dart';
import 'package:to_do_tasks/utils/app_text_style.dart';
import 'package:to_do_tasks/utils/utils.dart';

class TodoItemWidget extends StatefulWidget {
  Todo todoItem;
  TodoBloc bloc;

  TodoItemWidget({required this.todoItem, required this.bloc, Key? key}) : super(key: key);

  @override
  _TodoItemWidgetState createState() => _TodoItemWidgetState();
}

class _TodoItemWidgetState extends State<TodoItemWidget> {
  bool buttonSelected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Row(
          children: [
            Checkbox(
                value: widget.todoItem.isDone,
                checkColor: Colors.yellowAccent,  // color of tick Mark
                activeColor: Colors.grey,
                onChanged: ( value) {
                  setState(() {
                    widget.todoItem.isDone = value ?? false;
                    widget.bloc.updateTodoTask(widget.todoItem);
                  });
                }),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todoItem.title,
                  style: AppTextStyle.todoTitle(),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.todoItem.dateTime,
                  style: AppTextStyle.dueDate(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
