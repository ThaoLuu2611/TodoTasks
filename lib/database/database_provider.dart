import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:to_do_tasks/models/todo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:io';
import 'package:to_do_tasks/utils/utils.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class DatabaseProvider {
  final String _dbBoxName = 'TodoTasks';
  late Box _dbBox;
  List<Todo> listInCompletedTasks = [];
  List<Todo> listCompletedTasks = [];

  static DatabaseProvider? _instance;

  DatabaseProvider._();

  static DatabaseProvider get instance => _instance ??= DatabaseProvider._();

  Box getBox() {
    return _dbBox;
  }

  Future<Box> initDatabase(String? tableName) async {
    WidgetsFlutterBinding.ensureInitialized();
    Hive.init(Directory.current.path);
    final _appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(_appDocumentDir.path);
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter<Todo>(TodoAdapter());
    }

    _dbBox = await Hive.openBox(tableName ?? _dbBoxName);
    return _dbBox;
  }

  List<Todo> getAllTodoList() {
    List<Todo> listTasks = [];
    _dbBox.toMap().values.forEach((element) => {listTasks.add(element)});
    return listTasks;
  }

  List<Todo> getListInCompletedTasks() {
    List<Todo> listTasks = [];
    _dbBox
        .toMap()
        .values
        .forEach((element) => {if (!element.isDone) listTasks.add(element)});

    return listTasks;
  }

  List<Todo> getListCompletedTasks() {
    List<Todo> listTasks = [];
    _dbBox
        .toMap()
        .values
        .forEach((element) => {if (element.isDone) listTasks.add(element)});

    return listTasks;
  }

  Future<void> insertNewTask(Todo task) async {
    task.dateTime = Utils.getCurrentTime();
    await _dbBox
        .add(task)
        .then((key) => {task.id = key, _dbBox.put(key, task)});
  }

  Future<void> updateTasks(Todo task) async {
    await _dbBox.putAt(task.id, task);
  }

  clearDb(String? dbName) {
    Hive.box(dbName ?? _dbBoxName).clear();
  }
}
