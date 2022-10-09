import 'package:flutter_test/flutter_test.dart';
import 'package:komekt_4/friends.dart';
import 'package:komekt_4/game_logic.dart';

Future main() async {
  test('GameLogic_initializes_properly', () async {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    
  });
}