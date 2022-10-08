import 'package:flutter/material.dart';
import 'package:komekt_4/game_logic.dart';
import 'package:komekt_4/komekt_board.dart';

class GameScreen extends StatefulWidget {
  GameScreen({super.key, required this.game});

  final GameLogic game;

  String player_text = 'Player\'s turn';

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>{
  _GameScreenState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Game Name Placeholder'),),
      body: Column(children: [
        Expanded(flex: 2, child: Container(color: Theme.of(context).backgroundColor)),
        Center(
          child: AspectRatio(
            aspectRatio: 7/6,
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.black38),
                    ),
                    child: Komekt4Pieces(
                      board: widget.game
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
                    children: List.generate(widget.game.gridList.length, (index) {
                      return Flexible(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (widget.game.player == 1) {
                                widget.game.gridList = widget.game.makeMove(index, 1, widget.game.deepCopy(widget.game.gridList));
                                widget.game.friend.send(index.toString());
                                if (widget.game.winner(widget.game.gridList) == 1) {
                                  widget.game.player = 0;
                                  widget.player_text = 'You won!';
                                } else if (widget.game.winner(widget.game.gridList) == -1) {
                                  widget.game.player = 0;
                                  widget.player_text = 'You lost!';
                                } else {
                                  widget.game.player = -1;
                                  widget.player_text = 'Opponent\'s turn';
                                }
                              }
                            });
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
        ),
        Expanded(flex: 5, child:
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child: Column(children: [
              const Spacer(flex: 2),
              Text(widget.player_text, textScaleFactor: 4,),
              const Spacer(flex: 3),
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
