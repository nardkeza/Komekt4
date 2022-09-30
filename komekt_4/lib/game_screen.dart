import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key});

  int row = 5;
  int column = 5;

  var gridList = List.generate(5, (i) => 5, growable: false);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Game Name Placeholder'),),
      body: Column(children: [
        const Text('placeholder'),
        const Text('Friend turn'),
        Row(children: [
          IconButton(onPressed: (() {}), icon: const Icon(Icons.done)),
          IconButton(onPressed: (() {}), icon: const Icon(Icons.close)),
          ]),
      ]),
    );
  }
}