import 'package:flutter_test/flutter_test.dart';
import 'package:komekt_4/friends.dart';

void main(){
  test('one', (){
    Friends friend = Friends();
    friend.add("NF", "127.6.57.03");
    expect(friend.ipAddr("nf"), "127.6.57.03");
  });

  test('two', (){
    Friends nf = Friends();
    nf.add("Tester1", "123.56.68.3");
    nf.add("test2", "34.78.55.0");
    expect(nf.getFriend("test2"), "test2");
    expect(nf.getFriendByIP("34.78.55.0"),"34.78.55.0");
  });
}