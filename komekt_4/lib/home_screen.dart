import 'package:flutter/material.dart';
import 'package:komekt_4/alert_dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  

  @override
  State<StatefulWidget> createState() =>_HomeScreenState();   
}
class _HomeScreenState extends State<HomeScreen>{

  @override
  void initState(){
    super.initState();
  }
  
  Future<void> _displayAlertDialog(BuildContext context, bool addFriend, [Map<String, String> friends = const <String, String> {}]) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(addFriend: addFriend, friends: friends);
        });
  }
  
  String gameName = "Testing";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komekt 4'),
        actions: [IconButton(onPressed: (() {_displayAlertDialog(context, true);}), icon: const Icon(Icons.person_add))],
        ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: <Widget>[
          Card(child:ListTile(title: Text(gameName), onTap: (){})
          ),
          Card(child:ListTile(title: Text("Formatting Check"), onTap: (){})
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _displayAlertDialog(context, false, <String, String> {'Friend 1': 'ip 1', 'Friend 2': 'ip 2'}); // needs to be passed friends object
        }),
        child: const Icon(Icons.add), 
      ),
    );
  }
  
}