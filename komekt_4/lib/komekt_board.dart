import 'package:flutter/material.dart';

class Komekt4Game extends StatefulWidget {
  const Komekt4Game({Key? key, this.rows = 6, this.columns = 7})
      : super(key: key);

  final int rows;
  final int columns;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => Komekt4GameState(rows, columns);
}

class Komekt4GameState extends State<Komekt4Game> {
  Komekt4GameState(this.rows, this.columns);

  int rows;
  int columns;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 7/6,
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black38),
                ),
                child: const Komekt4Pieces(
                  rows: 6,
                  columns: 7,
                ),
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.black38),
                ),
                child: const Komekt4Board(
                  rows: 6,
                  columns: 7,
                ),
              ),
            ),
            Positioned.fill(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(columns, (index) {
                  return Flexible(
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(
                            index.toString()
                          ))
                        );
                      },
                    ),
                  );
                }),
              )
            )
          ],
        ),
      ),
    );
  }
}

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
  const Komekt4Pieces({Key? key, this.rows = 6, this.columns = 7})
      : super(key: key);

  final int rows;
  final int columns;

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => Komekt4PiecesState(rows, columns);
}

class Komekt4PiecePainter extends CustomPainter {
  Komekt4PiecePainter(this.rows, this.columns);

  int rows;
  int columns;

  @override
  void paint(Canvas canvas, Size size) {
    final redPiece = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final yellowPiece = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        final center = Offset(size.width/columns * (j + 0.5), size.height/rows * (i + 0.5));

        canvas.drawCircle(center, (size.width/columns) * .45, yellowPiece);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Komekt4PiecesState extends State<Komekt4Pieces> {
  Komekt4PiecesState(this.rows, this.columns);

  int rows;
  int columns;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: Komekt4PiecePainter(rows, columns));
  }
}