import 'package:flutter/material.dart';
import 'package:komekt_4/friends.dart';

class CustomAlert extends StatefulWidget {
  CustomAlert({super.key, required this.addFriend, required this.friends, required this.myIp});

  final bool addFriend;
  final String? myIp;

  final Friends friends; // type should be changed based on Friends implementation

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  
  String _ip = '';
  
  late String _dropdownvalue;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: (widget.addFriend)
      ?
      const Text('Add a Friend')
      :
      const Text('Add a Game'),
      content:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            (widget.myIp != null)
            ?
            Text(widget.myIp!)
            :
            const Text('No IP found'),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child:
                (widget.addFriend)
                ?
                Column( 
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  TextFormField(
                    
                    decoration: const InputDecoration(
                      labelText: 'Enter name...',
                    ),
                    onChanged: (text) => setState(() => _name = text),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter IP address...',
                    ),
                    onChanged: (text) => setState(() => _ip = text),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an IP address';
                      }
                      return null;
                    },
                  ),
                ])
                :
                Column( 
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  DropdownButtonFormField(
                    hint: const Text('Please select a friend...'),
                    items: widget.friends.toList().map((String friend) { // needs to be replaced with corresponding map for Friends inplementation.
                      return DropdownMenuItem(
                        value: friend,
                        child: Text(friend),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => _dropdownvalue = value!),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a friend';
                      }
                      return null;
                    },
                    
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter game name...',
                    ),
                    onChanged: (text) => setState(() => _name = text),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a game name';
                      }
                      return null;
                    },
                  ),
                ])
              ),
          ],
        ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.addFriend) {
                widget.friends.addNewFriend(_ip,_name);
              } else {
                List<List<int>> gridList =
                List.generate(7, (i) => (List.generate(6, ((index) => 0), growable: false)));
                // create new game
                // navigate to game screen
              }
            }
          },
          child: const Icon(Icons.check)
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.cancel),
        ),
      ],
    );
  }
}