import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class TaskProgressIndicator extends StatelessWidget {
  final MaterialColor? color;
  final progress;
  final _height = 3.0;
  const TaskProgressIndicator({@required this.color, @required this.progress});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Container(
                    height: _height,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  Container(
                    height: _height,
                    width: (progress / 100) * constraints.maxWidth,
                    color: color,
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0), //canh lề trái
          child: Text(
            '$progress%',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
      ],
    );
  }
}
