import 'dart:html';

import 'package:flutter/material.dart';
import 'package:komekt_4/friends.dart';

typedef GoToGameScreen = Function(Friend item);

class GameListItem extends StatelessWidget{

  GameListItem({
    required this.friend,
    required this.game_name,
    required this.onListTapped,
  }) : super(key: Key("Game with Friend"));

final Friend friend;
final String game_name;
final GoToGameScreen onListTapped;

@override
 Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () {
        onListTapped(friend);
      },
    ));
  }
}