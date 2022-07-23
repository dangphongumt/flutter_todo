import 'package:flutter/cupertino.dart';

class Todo {
  int id;
  String text;
  bool isCompleted;

  Todo({required this.id, required this.text, required this.isCompleted});
  Todo copy({String? text, bool? isCompleted, int? id}) {
    return Todo(
      id: id ?? this.id,
      text: text ?? this.text,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}