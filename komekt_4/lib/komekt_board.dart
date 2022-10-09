import 'package:flutter/material.dart';
import 'package:komekt_4/game_logic.dart';

class Komekt4Board extends StatelessWidget {
  const Komekt4Board({Key? key, this.rows = 6, this.columns = 7})
      : super(key: key);

  final int rows;
  final int columns;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: Komekt4BoardPainter(rows, columns));
  }

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
    return false;
  }
}

class Komekt4Pieces extends StatefulWidget {
  const Komekt4Pieces({Key? key, required this.board})
      : super(key: key);

  final GameLogic board;

  @override
  State<StatefulWidget> createState() => Komekt4PiecesState();
}

class Komekt4PiecePainter extends CustomPainter {
  Komekt4PiecePainter(this.board);

  GameLogic board;

  @override
  void paint(Canvas canvas, Size size) {
    int rows = board.gridList[0].length;
    int columns = board.gridList.length;
    final redPiece = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final yellowPiece = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    final greenPiece = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        final center = Offset(size.width/columns * (j + 0.5), size.height/rows * (i + 0.5));
        if (board.gridList[j][i] == 1) {
          canvas.drawCircle(center, (size.width/columns) * .45, yellowPiece);
        } else if (board.gridList[j][i] == -1) {
          canvas.drawCircle(center, (size.width/columns) * .45, redPiece);
        } else if (board.gridList[j][i] == 2) {
          canvas.drawCircle(center, (size.width/columns) * .45, greenPiece);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Komekt4PiecesState extends State<Komekt4Pieces> {
  Komekt4PiecesState();


  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: Komekt4PiecePainter(widget.board));
  }
}