import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/account/bloc/cubit_other.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Camera Permission'),
      content: const Text('We need permission to access your camera so you '
          'can take a picture.'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoButton(
          child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          onPressed: () {
            Navigator.pop(context);
            context.read<OtherCubit>().deleteUser();
          },
        ),
      ],
    );
  }
}