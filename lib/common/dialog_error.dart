import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.error});

  final String error;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Error'),
      content: Text(error),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}