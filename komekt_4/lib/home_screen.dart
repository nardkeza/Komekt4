import 'package:flutter/material.dart';

import 'package:komekt_4/game_screen.dart';
import 'dart:async';
import 'dart:io';
import 'package:mutex/mutex.dart';
import 'package:komekt_4/friends.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:komekt_4/alert_dialogs.dart';

  int ourPort = 8888;
  final m = Mutex();


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
    @override
  State<StatefulWidget> createState() =>_HomeScreenState();   
}
class _HomeScreenState extends State<HomeScreen>{
  String? _ipaddress = "Loading...";
  late TextEditingController _inputController, _nameController,_ipController;
  var items = ['Testing','Friend 2','Friend 1'];
  late String dropdownvalue;
  late Friends _friends;
  late List<DropdownMenuItem<String>> _friendList;
  late StreamSubscription<Socket> server_sub;
  late String game_name;

  @override
  void initState(){
    super.initState();
    _friends = Friends();
    _friends.add("Self", "127.0.0.1");
    _nameController = TextEditingController();
    _inputController = TextEditingController();
    _ipController = TextEditingController();
    game_name = "testing";
    _setupServer();
    _findIPAddress();
  }
  
  Future<void> _displayAlertDialog(BuildContext context, bool addFriend, [Map<String, String> friends = const <String, String> {}]) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(addFriend: addFriend, friends: friends);
        });
  }

    void addNew() {
    setState(() {
      _friends.add(_nameController.text, _ipController.text);
    });
  }

  Future<void> _findIPAddress() async {
    // Thank you https://stackoverflow.com/questions/52411168/how-to-get-device-ip-in-dart-flutter
    String? ip = await NetworkInfo().getWifiIP();
    setState(() {
      _ipaddress = "My IP: " + ip!;
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
  
  
  String gameName = "Testing";

void _handleListClick(){
   Navigator.of(context).push(MaterialPageRoute(
    builder: (context)=> GameScreen()));

}

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
          Card(child:ListTile(title: Text(game_name), onTap: (){
           _handleListClick();
          })
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