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

        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}