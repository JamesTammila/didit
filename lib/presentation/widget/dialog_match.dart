import 'package:flutter/material.dart';

class MatchDialog extends StatelessWidget {
  const MatchDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tell James what to post next."),
      content: TextFormField(
        maxLength: 100,
        maxLines: 5,
        decoration: const InputDecoration(border: InputBorder.none),
        onChanged: (s) => {},
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