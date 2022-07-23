import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  const GradientBackground({required this.child, required this.color});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      decoration: BoxDecoration(
        //Box decoration takes a gradient
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          //Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.3, 0.5, 0.7, 0.9],
          colors: [
            //Colors are easy thanks to Flutter's Colors class.
            color[300] as Color,
            color[600] as Color,
            color[700] as Color,
            color[900] as Color,
          ],
        ),
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
      child: child,
    );
  }
}