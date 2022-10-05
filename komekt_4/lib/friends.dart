
import 'package:flutter/cupertino.dart';

class Friends extends Iterable<String>{
  Map<String, Friend> _namesOfFriends= {};
  Map<String, Friend> _ipsOfFriends = {};

  void add(String name, String ip){
    Friend nf = Friend(ipAddr: ip, name: name);
    _namesOfFriends[name] = nf;
    _ipsOfFriends[name] = nf;
  }

  void addNewFriend(String ip){
    if(!_ipsOfFriends.containsKey(ip)){
      String newFriend = "Friend${_ipsOfFriends.length}";
      add(newFriend, ip);
    }
  }

  String? ipAddr(String? name)=>_namesOfFriends[name]?.ipAddr;

  Friend? getFriend(String? name) => _namesOfFriends[name];

  @override
  Iterator<String> get iterator => _namesOfFriends.keys.iterator;
}
class Friend extends ChangeNotifier{
  final String ipAddr;
  final String name;

  Friend({required this.ipAddr, required this.name});

}