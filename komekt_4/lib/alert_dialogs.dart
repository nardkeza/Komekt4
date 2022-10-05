import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert({super.key, required this.addFriend, required this.friends});

  final bool addFriend;

  final Map<String, String> friends; // type should be changed based on Friends implementation

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
      title: const Text('Item To Add'),
      content:
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
                items: widget.friends.keys.map((String friend) { // needs to be replaced with corresponding map for Friends inplementation.
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
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (widget.addFriend) {
                // add friend to list
              } else {
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