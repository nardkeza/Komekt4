import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:mutex/mutex.dart';

  int ourPort = 8888;
  final m = Mutex();

class Friends extends Iterable<String>{
  Map<String, Friend> _namesOfFriends= {};
  Map<String, Friend> _ipsOfFriends = {};

  void add(String name, String ip){
    Friend nf = Friend(ipAddr: ip, name: name);
    _namesOfFriends[name] = nf;
    _ipsOfFriends[ip] = nf;
  }

  void addNewFriend(String ip, String name){
    if(!_ipsOfFriends.containsKey(ip)){
      String newFriend = name;
      add(newFriend, ip);
    } 
  }
  void receiveMeg(String ip, String message){
    _ipsOfFriends[ip]!.receive(message);
  }

  String? ipAddr(String? name)=>_namesOfFriends[name]?.ipAddr;

  Friend? getFriend(String? name) => _namesOfFriends[name];

  @override
  Iterator<String> get iterator => _namesOfFriends.keys.iterator;
}
class Friend extends ChangeNotifier{
  final String ipAddr;
  final String name;
  final List<Coordinate> _coordinates = [];

  Friend({required this.ipAddr, required this.name});

    Future<void> _add_message(String message) async {
    await m.protect(() async {
      _coordinates.add(Coordinate(content: message));
      notifyListeners();
    });
  }
  Future<void> send(String coord) async {
    Socket socket = await Socket.connect(ipAddr, ourPort);
    socket.write(coord);
    socket.close();
  }
    Future<void> receive(String message) async {
    return _add_message(message);
  }
}
class Coordinate{
  final String content;

  const Coordinate({required this.content});
}
