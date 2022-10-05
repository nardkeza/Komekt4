import 'package:flutter/material.dart';

class CustomAlert extends StatefulWidget {
  const CustomAlert({super.key, required this.addFriend});

  final bool addFriend;

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {

  final _formKey = GlobalKey<FormState>();

  String _name = '';

  String _ip = '';

  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Item To Add'),
      content:
        Form(
          child:
            (widget.addFriend)
            ?
            Column( children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter name...',
                ),
                onChanged: (text) => setState(() => _name = text),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter IP address...',
                ),
                onChanged: (text) => setState(() => _ip = text),
              ),
            ])
            :
            Column( children: [
              DropdownButtonFormField(
                
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter game name...',
                ),
                onChanged: (text) => setState(() => _name = text),
              ),
            ])
          )
      actions: <Widget>[
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _inputController,
          builder: (context, value, child) {
            return ElevatedButton(
              key: const Key("OKButton"),
              style: yesStyle,
              child: const Text('OK'),
              onPressed: value.text.isNotEmpty
                ? () {
                    setState(() {
                      _handleNewItem(valueText, widget.category);
                      Navigator.pop(context);
                    });
                  }
                : null,
            );
          },
        ),

        // https://stackoverflow.com/questions/52468987/how-to-turn-disabled-button-into-enabled-button-depending-on-conditions
        ElevatedButton(
          key: const Key("CancelButton"),
          style: noStyle,
          onPressed: () {
            setState(() {
              Navigator.pop(context);
            });
          },c
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}