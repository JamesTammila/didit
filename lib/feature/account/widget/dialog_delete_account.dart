import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/account/bloc/cubit_other.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Delete Account'),
      content: const Text('Are you sure you want to delete your account?'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          onPressed: () {
            context.pop();
            context.read<OtherCubit>().deleteUser();
          },
        ),
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}