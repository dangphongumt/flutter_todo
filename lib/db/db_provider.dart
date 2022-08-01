import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/todo_model.dart';

class DBProvider {
  static Database? _database;

  DBProvider._();
  static final DBProvider db = DBProvider._();

  var todos = [
    Todo(
      "Vegetable",
      parent: '1',
    ),
    Todo(
      "Birthday gift",
      parent: '1',
    ),
    Todo(
      "Chocolate cookies",
      parent: '1',
      isCompleted: 1,
    ),
    Todo(
      '20 pushups',
      parent: '2',
    ),
    Todo(
      "Tricep",
      parent: '2',
    ),
    Todo(
      "25 burpees(3 sets)",
      parent: '2',
    ),
  ];

  var tasks = [
    Task(
      "Shopping",
      color: Colors.purple.value,
      codePoint: Icons.shopping_cart.codePoint,
      id: '1',
    ),
    Task(
      'Workout',
      color: Colors.pink.value,
      codePoint: Icons.fitness_center.codePoint,
      id: '2',
    ),
  ];
  Future<Database> get database async {
    return _database ?? await initDB();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  initDB() async {
    String path = await _dbPath;
  }

  get _dbPath async {
    String documentDirectory = await _localPath;
    return p.join(documentDirectory, 'Todo.db');
  }

  Future<bool> dbExists() async {
    return File(await _dbPath).exists();
  }

  insertBulkTask(List<Task> tasks) async {
    final db = await database;
    tasks.forEach((it) async {
      var res = await db.insert("Task", it.toJson());
      print("Task ${it.id} = $res");
    });
  }

  insertBulkTodo(List<Todo> todos) async {
    final db = await database;
    todos.forEach((element) async {
      var res = await db.insert("Todo", element.toJson());
      print("Todo ${element.id} = $res");
    });
  }

  Future<List<Task>> getAllTask() async {
    final db = await database;
    var result = await db.query('Task');
    return result.map((e) => Task.fromJson(e)).toList();
  }

  Future<List<Todo>> getAllTodo() async {
    final db = await database;
    var result = await db.query('Todo');
    return result.map((e) => Todo.fromJson(e)).toList();
  }
}
