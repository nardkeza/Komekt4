
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:komekt_4/game_logic.dart';

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
  late StreamSubscription<Socket> server_sub;
  late Map<String, GameLogic> gamelist;


  @override
  void initState(){
    super.initState();
    _friends = Friends();
    _friends.add("Self", "127.0.0.1");
    _nameController = TextEditingController();
    _inputController = TextEditingController();
    _ipController = TextEditingController();
    _setupServer();
    _findIPAddress();
    gamelist = {};
  }
  
  Future<void> _displayAlertDialog(BuildContext context, bool addFriend) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomAlert(addFriend: addFriend, friends: _friends, myIp: _ipaddress, onNewGame: _passList);
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
    void _listenToSocket(Socket socket) {
    socket.listen((data) {
      setState(() {
        _handleIncomingMessage(socket.remoteAddress.address, data);
      });
    });
  }

   void _handleIncomingMessage(String ip, Uint8List incomingData) {
    String received = String.fromCharCodes(incomingData);
    if (gamelist.containsKey(ip)) {
      setState(() {
        if (received == 'del') {
          gamelist.remove(ip);
        }else if (gamelist[ip]!.player == -1) {
          gamelist[ip]!.gridList = gamelist[ip]!.makeMove(int.parse(received), -1, gamelist[ip]!.deepCopy(gamelist[ip]!.gridList));
          gamelist[ip]!.gridList = gamelist[ip]!.finalizeMove();
          if (gamelist[ip]!.winner(gamelist[ip]!.gridList) == 0) {
            gamelist[ip]!.player = 1;
          } else {
            gamelist[ip]!.player = 0;
          }
        }
      });
      
    } else if (_friends.getFriendByIP(ip) != null){
      setState(() {
        gamelist.addAll({ip: GameLogic(friend: _friends.getFriendByIP(ip)!, gameName: 'Game against ${_friends.getFriendByIP(ip)!.name}')});
        gamelist[ip]!.player = -1;
        if (gamelist[ip]!.player == -1) {
          gamelist[ip]!.gridList = gamelist[ip]!.makeMove(int.parse(received), -1, gamelist[ip]!.deepCopy(gamelist[ip]!.gridList));
          gamelist[ip]!.gridList = gamelist[ip]!.finalizeMove();
          gamelist[ip]!.player = 1;
        }
      });
    }
    
  }

    Future<void> _setupServer() async {
    try {
      ServerSocket server =
          await ServerSocket.bind(InternetAddress.anyIPv4, ourPort);
      server_sub = server.listen(_listenToSocket); // StreamSubscription<Socket>
    } on SocketException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: $e"),
      ));
    }
  }
  

void _handleListClick(GameLogic game){
  if (game.player != -1) {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context)=> GameScreen(game: game,)));
    });
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(
        'It is not your turn yet'
      ))
    );
  }

}

bool _passList(String ip, GameLogic game){
  setState(() {
    if (!gamelist.keys.contains(ip)) {
      gamelist.addAll({ip: game});
    }
  });
  return !gamelist.keys.contains(ip);
}

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Komekt 4'),
        actions: [IconButton(onPressed: (() {_displayAlertDialog(context, true);}), icon: const Icon(Icons.person_add))],
        ),
        body: (gamelist.isEmpty)
        ?
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Press + to create a new game!', textScaleFactor: 1.5,),
        )
        :
        ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          children: gamelist.entries.map((game) {
            return Card(child:ListTile(
              title: Text(game.value.gameName),
              subtitle: Text(
                (game.value.winner(game.value.gridList) == 1)
                ?
                'You Won!'
                :
                (game.value.winner(game.value.gridList) == -1)
                ?
                'You Lost!'
                :
                (game.value.player == 1)
                ?
                'Player\'s turn'
                :
                'Opponent\'s turn',
              ),
              onTap: (){
                _handleListClick(game.value);
              },
              onLongPress: () {
                setState(() {
                  gamelist.remove(game.key);
                  game.value.friend.send('del');
                });
              },
            ));
          }).toList()          
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          setState(() {
            _displayAlertDialog(context, false); 
          });
// needs to be passed friends object
        }),
        child: const Icon(Icons.add), 
      ),
    );
  }
  
}