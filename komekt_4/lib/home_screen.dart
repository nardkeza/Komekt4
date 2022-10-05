import 'package:flutter/material.dart';
import 'package:komekt_4/alert_dialogs.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  

    @override
  State<StatefulWidget> createState() =>_HomeScreenState();   
}
class _HomeScreenState extends State<HomeScreen>{

  @override
  void initState(){
    super.initState();
  }
  
  Future<void> _displayAlertDialog(BuildContext context, bool addFriend) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(addFriend: addFriend);
        });
  }
  
  String game_name = "Testing";

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
          Card(child:ListTile(title: Text(game_name), onTap: (){})
          ),
          Card(child:ListTile(title:Text("Formatting Check"), onTap: (){})
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _displayAlertDialog(context, false); // needs to be passed friends object
        }),
        child: const Icon(Icons.add), 
      ),
    );
  }
  
}