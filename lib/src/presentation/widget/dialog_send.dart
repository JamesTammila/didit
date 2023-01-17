import 'package:flutter/material.dart';

class SendDialog extends StatelessWidget {
  const SendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tell James what to post next."),
      content: TextFormField(
        maxLength: 100,
        maxLines: 5,
        decoration: const InputDecoration(border: InputBorder.none),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Send"),
          onPressed: () => {},
        ),
      ],
    );
  }
}