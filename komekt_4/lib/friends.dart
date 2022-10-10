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
    _ipsOfFriends[name] = nf;
  }

  void addNewFriend(String name, String ip){
    if(!_ipsOfFriends.containsKey(ip)){
      String newFriend = name;
      add(newFriend, ip);
    } 
  }

  String? ipAddr(String? name)=>_namesOfFriends[name]?.ipAddr;

  Friend? getFriend(String? name) => _namesOfFriends[name];

  Friend? getFriendByIP(String? ip) => _ipsOfFriends[ip];

  @override
  Iterator<String> get iterator => _namesOfFriends.keys.iterator;
}
class Friend extends ChangeNotifier{
  final String ipAddr;
  final String name;

  Friend({required this.ipAddr, required this.name});


  Future<void> send(String coord) async {
    Socket socket = await Socket.connect(ipAddr, ourPort);
    socket.write(coord);
    socket.close();
  }
}
class Coordinate{
  final String content;

  const Coordinate({required this.content});
}
