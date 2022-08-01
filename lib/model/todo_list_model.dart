import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/db/db_provider.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/model/todo_model.dart';

class TodoListModel extends Model {
  //ObjectDB db;
  var _db = DBProvider.db;
  Map<String, int> _taskComletionPercentage = Map();
  bool _isLoading = false;
  List<Todo> _todos = [];
  List<Task> _tasks = [];

  List<Todo> get todos => _todos.toList();
  List<Task> get tasks => _tasks.toList();
  bool get isLoading => _isLoading;
  int getTaskComletionPercent(Task task) =>
      _taskComletionPercentage[task.id] ?? 0;
  int getTotalTodosFrom(Task task) =>
      todos.where((it) => it.parent == task.id).length;

  static TodoListModel of(BuildContext context) =>
      ScopedModel.of<TodoListModel>(context);

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
    super.addListener(listener);
    //update data for every subcriber, especialy for the first one
    _isLoading = true;
    loadTodos();
    notifyListeners();
  }

  void loadTodos() async {
    var isNew = !await DBProvider.db.dbExists();
    if (isNew) {
      await _db.insertBulkTask(_db.tasks);
      await _db.insertBulkTodo(_db.todos);
    }
    // var todos = [
    //   Todo(id: 234, text: "Meet clients", isCompleted: false),
    //   Todo(id: 444, text: "Design Sprint", isCompleted: false),
    //   Todo(id: 914, text: "iCon set design for Mobile app", isCompleted: true),
    // ];
    // _todos = todos;
    _tasks = await _db.getAllTask();
    _todos = await _db.getAllTodo();
    _tasks.forEach((element) => _calcTaskCompletionPercent(element.id));
    _isLoading = false;
    await Future.delayed(Duration(milliseconds: 300));
///////////////////////////////////
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.removeWhere((element) => element.id == todo.id);
    notifyListeners();
  }

  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo) {
    var oldTodo = _todos.firstWhere((element) => element.id == todo.id);
    var replaceIndex = _todos.indexOf(oldTodo);
    _todos.replaceRange(replaceIndex, replaceIndex + 1, [todo]);
    notifyListeners();
  }

  void _calcTaskCompletionPercent(String taskId) {
    var todos = this.todos.where((element) => element.parent == taskId);
    var totalTodos = todos.length;

    if (totalTodos == 0) {
      _taskComletionPercentage[taskId] = 0;
    } else {
      var totalCompletedTodos =
          todos.where((element) => element.isCompleted == 1).length;
      _taskComletionPercentage[taskId] =
          (totalCompletedTodos / totalTodos * 100).toInt();
    }
  }
}
