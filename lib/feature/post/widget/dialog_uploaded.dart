import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class UploadedDialog extends StatelessWidget {
  const UploadedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Uploaded'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}