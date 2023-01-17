import 'package:flutter/material.dart';
import 'package:didit/src/presentation/widget/dialog_send.dart';

class SendButton extends StatelessWidget {
  const SendButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => showDialog(
        context: context,
        builder: (BuildContext context) => const SendDialog(),
      ),
      child: const Text('Send DidIt'),
    );
  }
}