import 'package:flutter/material.dart';

class Komekt4Board extends StatefulWidget {
  const Komekt4Board({Key? key, this.rows = 20, this.columns = 20})
      : super(key: key);

  final int rows;
  final int columns;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => Komekt4BoardState(rows, columns);
}

class Komekt4BoardPainter extends CustomPainter {
  Komekt4BoardPainter(this.rows, this.columns);

  int rows;
  int columns;

  @override
  void paint(Canvas canvas, Size size) {
    final blackLine = Paint()..color = Colors.black;
    final blueFilled = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromPoints(Offset.zero, size.bottomLeft(Offset.zero)),
      blackLine,
    );
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        final a = Offset(size.width/columns * j, size.height/rows * i);
        final b = Offset(size.width/columns * (j + 1), size.height/rows * (i + 1));

        canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(Rect.fromPoints(a, b)),
          Path()
            ..addOval(Rect.fromCircle(center: Offset(size.width/columns * (j + 0.5), size.height/rows * (i + 0.5)), radius: (size.width/columns) * .4))
            ..close(),
        ),
        blueFilled,
    );
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Komekt4BoardState extends State<Komekt4Board> {
  Komekt4BoardState(this.rows, this.columns);

  int rows;
  int columns;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: Komekt4BoardPainter(rows, columns));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}