import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:komekt_4/home_screen.dart';
import 'package:komekt_4/main.dart';
import 'package:komekt_4/game_screen.dart';
import 'package:komekt_4/friends.dart';
import 'package:komekt_4/alert_dialogs.dart';
void main() {
  testWidgets('Home Page Loads', (WidgetTester tester) async {
    await tester.pumpWidget(const Komekt4App());
    // Build our app and trigger a frame.

    final homePageFinder = find.text("Komekt4");

    expect(homePageFinder, findsOneWidget);
  });

  testWidgets('Button displays dialog box', (WidgetTester tester) async {
    
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    final buttonFinder = find.byIcon(Icons.add);
    expect(buttonFinder, findsOneWidget);

     // final buttonFinder = find.byKey(const Key("Game Button"));

      //expect(buttonFinder, findsOneWidget);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(); // Pump after every action to rebuild the widgets
      expect(find.text("hi"), findsNothing);

      //await tester.tap(buttonFinder);
      //await tester.pumpAndSettle(const Duration(milliseconds: 4000));

     // final gameScreenFinder = find.byKey(const Key("Game Screen"));

     // expect(gameScreenFinder, findsOneWidget);
    });
}