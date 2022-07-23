import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/todo_model.dart';

class TodoListModel extends Model {
  List<Todo> get todos => _todos.toList();
  List<Todo> _todos = [];

  static TodoListModel of(BuildContext context) => ScopedModel.of(context);

  @override
  void addListener(VoidCallback listener) {
    // TODO: implement addListener
    super.addListener(listener);
    loadTodos();
  }

  void loadTodos() {
    var todos = [
      Todo(id: 234, text: "Meet clients", isCompleted: false),
      Todo(id: 444, text: "Design Sprint", isCompleted: false),
      Todo(id: 914, text: "iCon set design for Mobile app", isCompleted: true),
    ];
    _todos = todos;
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
}