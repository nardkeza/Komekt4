import 'package:flutter/material.dart';
import 'package:komekt_4/game_screen.dart';
import 'dart:async';
import 'dart:io';
import 'package:mutex/mutex.dart';

  int ourPort = 8888;
  final m = Mutex();

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  

    @override
  State<StatefulWidget> createState() =>_HomeScreenState();   
}
class _HomeScreenState extends State<HomeScreen>{
  final TextEditingController _inputController = TextEditingController();
  var items = ['Testing','Friend 2','Friend 1'];
  late String dropdownvalue;

  @override
  void initState(){
    super.initState();
    dropdownvalue = 'Testing';
  }
  final ButtonStyle yesStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize:20),
    primary: Colors.green
  );
  final ButtonStyle noStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    primary:  Colors.red
  );
  
  
    Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Put in the game name and choose which friend"),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  game_name = value;
                });
              },
              controller: _inputController,
            ),
            actions: <Widget>[
            DropdownButton(
             value: dropdownvalue,
             icon:const Icon(Icons.keyboard_arrow_down),
             items: items.map((String item){
              return DropdownMenuItem(
              value: item,
              child: Text(item),
              );
             }).toList(),
              onChanged: (String? value) { 
              setState(() {
                dropdownvalue = value!;
              });
             },
             ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _inputController,
              builder: (context, value, child) {
              return ElevatedButton(
                key: const Key("OkButton"),
                style: yesStyle,
                onPressed: value.text.isNotEmpty
                        ? () {
                  setState(() {
                    //_handleNewItem(valueText);
                    Navigator.pop(context);
                  });
                } : null,
                child: const Text('Accept'),
              );
              }
              ),
              ElevatedButton(
                    key: const Key("CancelButton"),
                    style: noStyle,
                    child: const Text("Cancel"),
                    onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          }                  
                  )
                  ]
          );
        });
  }

    Future<void> _setupServer() async {
    try {
      ServerSocket server =
          await ServerSocket.bind(InternetAddress.anyIPv4, ourPort);
      //server_sub = server.listen(_listenToSocket); // StreamSubscription<Socket>
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
      ));
    }
  }
  
  
String game_name = "Testing";

void _handleListClick(){

}

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
        children: <Widget>[
          Card(child:ListTile(title: Text(game_name), onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> GameScreen()));
          })
          ),
          Card(child:ListTile(title:Text("Formatting Check"), onTap: (){})
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