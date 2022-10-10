import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:komekt_4/game_screen.dart';
import 'package:komekt_4/game_logic.dart';
import 'package:komekt_4/friends.dart';


Future main() async {
  testWidgets('GameScreen_displays_game_name', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: GameScreen(game: 
          GameLogic(friend: 
            Friend(ipAddr: 'test_ip', name: 'test_name'), 
            gameName: 'test_game_name'
          ),
        ),
      ),
    );

    expect(find.text('test_game_name'), findsOneWidget);
  });
}