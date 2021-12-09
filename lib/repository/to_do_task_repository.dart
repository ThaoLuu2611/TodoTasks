import 'dart:async';

import 'package:to_do_tasks/database/database_provider.dart';
import 'package:to_do_tasks/models/todo.dart';

class TodoTaskRepository {
  Future<void> initDb(String? _dbName) async {
    await DatabaseProvider.instance.initDatabase(_dbName);
  }

  Future<List<Todo>> getAllTasks() async {
    return DatabaseProvider.instance.getAllTodoList();
  }

  Future<List<Todo>> getIncompletedTasks() async {
    return DatabaseProvider.instance.getListInCompletedTasks();
  }

  Future<List<Todo>> getCompletedTasks() async {
    return DatabaseProvider.instance.getListCompletedTasks();
  }

  Future<void> insertNewTask(Todo todoTask) async {
    await DatabaseProvider.instance.insertNewTask(todoTask);
  }

  Future<void> updateTodoTask(Todo todoTask) async {
    await DatabaseProvider.instance.updateTasks(todoTask);
  }

  Future<void> deleteDb(String? dbName) async {
    await DatabaseProvider.instance.clearDb(dbName);
  }
}
