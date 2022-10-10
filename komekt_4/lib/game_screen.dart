import 'package:flutter/material.dart';
import 'package:komekt_4/game_logic.dart';
import 'package:komekt_4/komekt_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.game});

  final GameLogic game;

  @override
  State<StatefulWidget> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>{
  _GameScreenState();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(widget.game.gameName),),
      body: Column(children: [ // https://stackoverflow.com/questions/56410074/how-to-set-the-background-color-of-a-row-in-flutter
        Expanded(flex: 2, child: Container(color: Theme.of(context).backgroundColor)),
        Expanded(
          flex: 5,
          child: Center(
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
                          child: GestureDetector( // https://stackoverflow.com/questions/61277259/gesturedetector-not-detecting-inside-of-list-generate
                            onTap: () {
                              setState(() {
                                if (widget.game.player == 1) {
                                  widget.game.gridList = widget.game.makeMove(index, 1, widget.game.deepCopy(widget.game.gridList));
                                }
                              });
                            },
                            behavior: HitTestBehavior.translucent,
                          ),
                        );
                      }),
                    )
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(flex: 5, child:
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).backgroundColor,
            child: Column(children: [
              const Spacer(flex: 2),
              Flexible(flex: 4, child: Text(
                (widget.game.winner(widget.game.gridList) == 1)
                ?
                'You Won!'
                :
                (widget.game.winner(widget.game.gridList) == -1)
                ?
                'You Lost!'
                :
                (widget.game.player == 1)
                ?
                'Player\'s turn'
                :
                'Opponent\'s turn',
                textScaleFactor: 3,
                )),
              const Spacer(flex: 3),
            ],),
        )),

        
        Row(children: [
          IconButton(iconSize: MediaQuery.of(context).size.width * 0.1, onPressed: (() {setState(() {
            Navigator.pop(context);
          });
          }), icon: const Icon(Icons.close)),

          const Spacer(),
          IconButton(iconSize: MediaQuery.of(context).size.width * 0.1, onPressed: (() {
            setState(() {
              if (widget.game.tempMove != null) {
                int move = widget.game.tempMove![0];
                widget.game.gridList = widget.game.finalizeMove();
                widget.game.friend.send(move.toString());
                if (widget.game.winner(widget.game.gridList) == 1) {
                  widget.game.player = 0;
                } else if (widget.game.winner(widget.game.gridList) == -1) {
                  widget.game.player = 0;
                } else {
                  widget.game.player = -1;
                }
                Navigator.pop(context);
              }
            });
          }), icon: const Icon(Icons.done)),
          ]),
      ]),
    );
  }
}
