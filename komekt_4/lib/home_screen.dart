import 'package:flutter/material.dart';

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
    dropdownvalue = "Testing";
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
            DropdownButton(value: dropdownvalue,
             icon:const Icon(Icons.keyboard_arrow_down),
             items: items.map((String item){
              return DropdownMenuItem(value: item,
              child: Text(item),
              );
             }).toList(),
             onChanged: (String? newValue){
              setState(() {
                dropdownvalue = newValue!;
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