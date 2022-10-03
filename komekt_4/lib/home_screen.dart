import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  

    @override
  State<StatefulWidget> createState() =>_HomeScreenState();   
}
class _HomeScreenState extends State<HomeScreen>{
  final TextEditingController _inputController = TextEditingController();
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize:20),
    primary: Colors.green
  );
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    primary:  Colors.red
  );
  Future<void> _displayTextInputDialog(BuildContext context){
    return showDialog(context: context,
     builder: (context){
        return AlertDialog(
          title: const Text ("Set the Game Name"),
          content: TextField(
            onChanged: (value){
              setState(() {
                game_name = value;
              });
            },
            controller: _inputController,
            decoration: 
              const InputDecoration(hintText: "Type the game name"),
          ),
          actions: <Widget>[
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _inputController,
              builder: ((context, value, child) {
                return ElevatedButton(
                  key: const Key("Accept"),
                  style: yesStyle,
                  onPressed: value.text.isNotEmpty
                  ?(){
                setState(() {
                  //_handleNewItem(valueText);
                  Navigator.pop(context);
                });
              } : null,
              child: const Text("Accept"),
              );
              }
              ),
            child: ElevatedButton(
              key: const Key("Cancel"),
              style: noStyle,
              child: const Text("cancel"),
              onPressed: (){
                setState(() {
                  Navigator.pop(context);
                });
              }
            )
          ),
        ]
        );
     });
  }
  
String game_name = "";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komekt 4'),
        actions: [IconButton(onPressed: (() {}), icon: const Icon(Icons.person_add))],
        ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: const<Widget>[
          Card(child:ListTile(title: Text("Test"))
          ),
          Card(child:ListTile(title:Text("Formatting Check"))
          )
        ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          _displayTextInputDialog(context);
        }),
        child: const Icon(Icons.add),
        
      ),
    );
  }
  
}