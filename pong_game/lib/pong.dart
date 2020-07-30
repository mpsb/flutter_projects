import 'package:flutter/material.dart';
import 'package:pong_game/ball.dart';
import 'package:pong_game/bat.dart';
import 'dart:math';

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
  int score = 0;
  double diam = 50;
  double increment = 5;
  double width;
  double height;
  double randX = 1;
  double randY = 1;
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  double randomNumber() {
    var ran = new Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diam && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - diam - batHeight && vDir == Direction.down) {
      if (posX >= (batPosition - diam) &&
          posX <= (batPosition + batWidth + diam)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
        });
      } else {
        controller.stop();
        showEndMessage(context);
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
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
      safeSetState(() {
        (hDir == Direction.right)
            ? posX += (increment * randX).round()
            : posX -= (increment * randX).round();
        (vDir == Direction.down)
            ? posY += (increment * randY).round()
            : posY -= (increment * randY).round();
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> v = [
      Positioned(
        top: 0,
        right: 24,
        child: Text('Score: ' + score.toString()),
      ),
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
    ];

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width / 6;
        batHeight = height / 20;

        return Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              right: 24,
              child: Text('Score: ' + score.toString()),
            ),
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
    safeSetState(() {
      batPosition += update.delta.dx;
      if (batPosition <= 0) {
        batPosition = 0;
      }
      if (batPosition >= (width - batWidth)) {
        batPosition = width - batWidth;
      }
    });
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  void showEndMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game over.'),
            content: Text('Would you like to play again?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    posX = 0;
                    posY = 0;
                    score = 0;
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                  dispose();
                },
              ),
            ],
          );
        });
  }
}
