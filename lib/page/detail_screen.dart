import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:todo/model/hero_id_model.dart';
import 'package:todo/model/todo_list_model.dart';

class DetailScreen extends StatefulWidget {
  final double progress;
  final Color color;
  final int codePoint;
  final int id;
  final HeroId heroIds;

  const DetailScreen(
      {required this.codePoint,
      required this.color,
      required this.progress,
      required this.id,
      required this.heroIds});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 280),
    );
    _animation = Tween<Offset>(begin: Offset(0, 1.0), end: Offset(0.0, 0.0))
        .animate(_controller);

    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return ScopedModelDescendant<TodoListModel>(
        builder: (BuildContext context, Widget child, TodoListModel model) {
      return Theme(
          data: ThemeData(primarySwatch: widget.color as MaterialColor),
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black26),
              brightness: Brightness.light,
              backgroundColor: Colors.white,
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 36.0, vertical: 0.0),
                    height: 160,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start),
                  )
                ],
              ),
            ),
          ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}