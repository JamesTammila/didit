import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_edit.dart';

class CameraPictureDialog extends StatelessWidget {
  const CameraPictureDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Camera Permission'),
      content: const Text('We need permission to access your camera so you '
          'can post.'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
            context.read<EditCubit>().openSettings();
          },
        ),
      ],
    );
  }
}