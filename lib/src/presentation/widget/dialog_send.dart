import 'package:flutter/material.dart';

class SendDialog extends StatelessWidget {
  const SendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Tell James what to post next."),
      actions: <Widget>[
        TextFormField(
          maxLength: 100,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              child: const Text("Send"),
              onPressed: () => {},
            ),
          ],
        )
      ],
    );
  }
}