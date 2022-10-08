import 'package:flutter/material.dart';
import 'package:komekt_4/game_logic.dart';
import 'package:komekt_4/komekt_board.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key, required this.game});

  final GameLogic game;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

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
                rows: 6,
                columns: 7,
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
          IconButton(iconSize: MediaQuery.of(context).size.width * 0.1, onPressed: (() {Navigator.pop(context);}), icon: const Icon(Icons.close)),

          const Spacer(),
          IconButton(iconSize: MediaQuery.of(context).size.width * 0.1, onPressed: (() {}), icon: const Icon(Icons.done)),
          ]),
      ]),
    );
  }
}
