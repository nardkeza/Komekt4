import 'package:flutter/material.dart';
import 'package:komekt_4/komekt_board.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  int row = 5;
  int column = 5;
  String R = "red";
  String Y = "yellow";

  var gridList = List.generate(5, (i) => 5, growable: false);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const int _rows = 6;
    const int _columns = 7;
    double _buttonSize = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      appBar: AppBar(title: const Text('Game Name Placeholder'),),
      body: Column(children: [
        Expanded(flex: 2, child: Container(color: Theme.of(context).backgroundColor)),
        Center(
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black38),
            ),
            child: const AspectRatio(
              aspectRatio: 7/6,
              child: Komekt4Board(
                rows: _rows,
                columns: _columns,
              ),
            ),
          ),
        ),
        Expanded(flex: 5, child:
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child: Column(children: const [
              Spacer(flex: 2),
              Text('Friend turn', textScaleFactor: 4,),
              Spacer(flex: 3),
            ],),
        )),

        
        Row(children: [
          IconButton(iconSize: _buttonSize, onPressed: (() {}), icon: const Icon(Icons.close)),
          const Spacer(),
          IconButton(iconSize: _buttonSize, onPressed: (() {}), icon: const Icon(Icons.done)),
          ]),
      ]),
    );
  }
}