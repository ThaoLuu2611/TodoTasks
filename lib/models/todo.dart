import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo {
  Todo({required this.title, required this.isDone});

  @HiveField(0)
  int id = 0;

  @HiveField(1)
  String title = "";

  @HiveField(2)
  bool isDone = false;

  @HiveField(3)
  String dateTime = '';

  @override
  String toString() {
    return '$title: $isDone';
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }
}
