import 'package:flutter/material.dart';
import 'package:komekt_4/home_screen.dart';
import 'package:komekt_4/game_screen.dart';

void main() {
  runApp(const Komekt4App());
}

class Komekt4App extends StatelessWidget {
  const Komekt4App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komekt 4',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const GameScreen(),
    );
  }
}