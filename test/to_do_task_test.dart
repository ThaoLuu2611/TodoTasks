import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_tasks/bloc/to_do_bloc.dart';
import 'package:to_do_tasks/database/database_provider.dart';
import 'package:flutter/services.dart';
import 'package:to_do_tasks/models/todo.dart';

void main() {
  final _bloc = TodoBloc();
  var _boxName = 'TestTodoTask';

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    const MethodChannel channel =
    MethodChannel('plugins.flutter.io/path_provider');
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return ".";
    });
    await _bloc.initDatabase(_boxName);
  });

  group('Todo task', () {
    test('Test length of all task list should be 0 when none task has been added', () async {
      int length = _bloc.listAllTasks.length;
      expect(length, 0);
    });

    test('Test length of all task list should be 1 when add new todo task', () async {
      var todoTask = Todo(
        title: 'Study history',
        isDone: true,
      );
      int length;
      await _bloc.addNewTask(todoTask);
        length = _bloc.listAllTasks.length;
        expect(length, 1);
    });

    test('Test value of newly added todo task', () async {
      var todoTask = Todo(
        title: 'Study history',
        isDone: false,
      );
      int length;
      await _bloc.addNewTask(todoTask);
      length = _bloc.listAllTasks.length;
      Todo item = _bloc.listAllTasks[length - 1];
      expect(item.title, 'Study history');
      expect(item.title, isNot('Go shopping'));
      expect(item.isDone, false);
    });

    test('Test first value when add multi item', () async {
      var todoTask1 = Todo(
        title: 'Do homework',
        isDone: true,
      );
      var todoTask2 = Todo(
        title: 'Doing Yoga',
        isDone: false,
      );
      await _bloc.addNewTask(todoTask1);
      await _bloc.addNewTask(todoTask2);
      Todo item = _bloc.listAllTasks[0];
      expect(item.title, 'Do homework');
      expect(item.title, isNot('Go shopping'));
      expect(item.isDone, true);
    });

    test('Test update to do task', () async {
      var todoTask = Todo(
        title: 'Conduct meeting with client',
        isDone: false,
      );
      await _bloc.addNewTask(todoTask);
      int length = _bloc.listAllTasks.length;
      Todo item = _bloc.listAllTasks[length - 1];
      item.isDone = true;
      item.title = 'Cancel meeting with client';
      await _bloc.updateTodoTask(item);
      expect(item.title, 'Cancel meeting with client');
      expect(item.title, isNot('Conduct meeting with client'));
      expect(item.isDone, true);
    });
  });

  tearDown(() {
    DatabaseProvider.instance.clearDb(_boxName);
  });
}
