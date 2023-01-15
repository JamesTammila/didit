import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => {},
      child: const Text('Send DidIt'),
    );
  }
}