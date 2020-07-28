import 'package:flutter/material.dart';
import 'package:pong_game/ball.dart';
import 'package:pong_game/bat.dart';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;
  Animation<double> animation;
  AnimationController controller;
  double increment = 5;
  double width;
  double height;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= width - 50 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= height - 50 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(seconds: 10000),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width / 5;
        batHeight = height / 20;

        return Stack(
          children: <Widget>[
            Positioned(
              child: Ball(),
              top: posY,
              left: posX,
            ),
            Positioned(
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails update) =>
                      moveBat(update),
                  child: Bat(batWidth, batHeight)),
              bottom: 0,
              left: batPosition,
            ),
          ],
        );
      },
    );
  }

  void moveBat(DragUpdateDetails update) {
    setState(() {
      batPosition += update.delta.dx;
    });
  }
}