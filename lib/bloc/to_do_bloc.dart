import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:to_do_tasks/models/todo.dart';
import 'package:to_do_tasks/repository/to_do_task_repository.dart';
import 'package:to_do_tasks/utils/utils.dart';

class TodoBloc {
  final _listAllTodoTasksController = StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get allTodoTaskStream =>
      _listAllTodoTasksController.stream;

  final _listIncompletedTasksController =
      StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get inCompletedTaskStream =>
      _listIncompletedTasksController.stream;

  final _listCompletedTasksController =
      StreamController<List<Todo>>.broadcast();

  Stream<List<Todo>> get completedTasksStream =>
      _listCompletedTasksController.stream;

  TextEditingController todoTextController = TextEditingController();

  var repository = TodoTaskRepository();

  var listAllTasks = <Todo>[];
  var listIncompletedTasks = <Todo>[];
  var listCompletedTasks = <Todo>[];

  setTodoController(String value) {
    todoTextController.text = value;
  }

  getAllTasks() {
    repository.getAllTasks().then((value) => {
          listAllTasks = value,
          _listAllTodoTasksController.sink.add(listAllTasks)
        });
  }

  getIncompletedTask() {
    repository.getIncompletedTasks().then((value) => {
          listIncompletedTasks = value,
          _listIncompletedTasksController.sink.add(value)
        });
  }

  getCompletedTask() {
    repository.getCompletedTasks().then((value) => {
          listCompletedTasks = value,
          _listCompletedTasksController.sink.add(value)
        });
  }

  Future<void> initDatabase(String? _dbName) async {
    await repository.initDb(_dbName);
  }

  Future<void> addNewTask(Todo newTodoTask) async {
    await repository.insertNewTask(newTodoTask);
    await refreshListTasks();
  }

  Future<void> updateTodoTask(Todo todoTask) async {
    await repository.updateTodoTask(todoTask);
    await refreshListTasks();
  }

  refreshListTasks() {
    switch (Utils.selectedScreen) {
      case 0:
        getAllTasks();
        break;
      case 1:
        getCompletedTask();
        break;
      case 2:
        getIncompletedTask();
        break;
    }
  }

  Future<void> clearDb(String? dbName) async {
    repository.deleteDb(dbName);
  }

  void dispose() {
    _listAllTodoTasksController.close();
    _listIncompletedTasksController.close();
    _listCompletedTasksController.close();
  }
}
