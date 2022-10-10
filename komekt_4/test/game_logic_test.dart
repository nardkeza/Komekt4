import 'package:flutter_test/flutter_test.dart';
import 'package:komekt_4/friends.dart';
import 'package:komekt_4/game_logic.dart';

Future main() async {
  test('GameLogic_initializes_properly', () {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    
    expect(game.friend, isA<Friend>());
    expect(game.gameName, 'test_game_name');
    expect(game.player, 1);
    expect(game.tempMove, null);
    expect(game.gridList, List.generate(7, (i) => List.generate(6,(index)=>0, growable: false)));
  });
  test('GameLogic_deepcopies_states', () {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    List<List<int>> testGrid = List.generate(7, (i) => List.generate(6,(index)=>index, growable: false));

    List<List<int>> resultGrid = game.deepCopy(testGrid);

    expect(testGrid, resultGrid);
    expect(testGrid == resultGrid, false);
  });
  test('GameLogic_makes_temporary_move', () {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    List<List<int>> testGrid = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ];
    List<List<int>> trueGrid = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [1, 2, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ];

    List<List<int>> resultGrid = game.makeMove(2, -1, testGrid);

    expect(trueGrid, resultGrid);
  });
  test('GameLogic_finalizes_temporary_move', () {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    List<List<int>> testGrid = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [1, 2, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ];
    List<List<int>> trueGrid = [
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [1, -1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0]
    ];

    game.gridList = testGrid;
    game.tempMove = [2, 1, -1];
    List<List<int>> resultGrid = game.finalizeMove();

    expect(trueGrid, resultGrid);
  });
  test('GameLogic_gets_valid_moves', () {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    List<List<int>> testGrid = [
      [1, -1, 1, -1, 1, 0],
      [1, -1, 1, -1, 1, 1],
      [1, -1, -1, 1, 0, 0],
      [-1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, -1, -1, -1, 1],
      [0, 0, 0, 0, 0, 0]
    ];
    List<int> trueMoves = [0, 2, 3, 4, 6];

    List<int> resultMoves = game.getValidMoves(testGrid);

    expect(trueMoves, resultMoves);
  });
  test('GameLogic_declares_winner', () {
    GameLogic game = GameLogic(friend: Friend(ipAddr: 'test_ip', name: 'test_name'), gameName: 'test_game_name');
    List<List<int>> testGrid0 = [
      [1, -1, 1, -1, 1, 0],
      [1, -1, 1, -1, 1, 1],
      [1, -1, -1, 1, 0, 0],
      [1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, -1, -1, -1, 1],
      [0, 0, 0, 0, 0, 0]
    ];
    List<List<int>> testGrid1 = [
      [1, -1, 1, -1, 1, 0],
      [1, -1, -1, -1, 1, 1],
      [1, -1, -1, 1, 0, 0],
      [-1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, -1, -1, -1, 1],
      [0, 0, 0, 0, 0, 0]
    ];
    List<List<int>> testGrid2 = [
      [-1, -1, 1, -1, 1, 0],
      [1, -1, 1, -1, 1, 1],
      [1, -1, -1, 1, 0, 0],
      [-1, 1, -1, 0, 0, 0],
      [1, 1, 1, -1, 0, 0],
      [-1, 1, -1, -1, -1, 1],
      [0, 0, 0, 0, 0, 0]
    ];
    List<List<int>> testGrid3 = [
      [1, -1, 1, -1, 1, 0],
      [1, -1, 1, -1, 1, 1],
      [1, -1, -1, 1, 0, 0],
      [-1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, -1, -1, -1, -1],
      [0, 0, 0, 0, 0, 0]
    ];
    List<List<int>> testGrid4 = [
      [1, -1, 1, -1, 1, 0],
      [1, -1, 1, -1, 1, 1],
      [1, -1, -1, 1, 0, 0],
      [-1, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0],
      [-1, 1, -1, -1, -1, 1],
      [0, 0, 0, 0, 0, 0]
    ];

    int result0 = game.winner(testGrid0);
    int result1 = game.winner(testGrid1);
    int result2 = game.winner(testGrid2);
    int result3 = game.winner(testGrid3);
    int result4 = game.winner(testGrid4);

    expect(result0, 1);
    expect(result1, -1);
    expect(result2, -1);
    expect(result3, -1);
    expect(result4, 0);
  });
}