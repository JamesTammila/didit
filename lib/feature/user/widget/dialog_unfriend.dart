import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';

class UnfriendDialog extends StatelessWidget {
  const UnfriendDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Unfriend User'),
      content: const Text('Are you sure you want to unfriend this person?'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('YES', style: TextStyle(color: Colors.red)),
          onPressed: () {
            context.pop();
            context.read<UserCubit>().unfriendUser();
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