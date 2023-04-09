import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/feature/friends/bloc/cubit_friends.dart';

class UnfriendDialog extends StatelessWidget {
  const UnfriendDialog({super.key, required this.friendModel});

  final FriendModel friendModel;

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
            context.read<FriendsCubit>().unfriendUser(friendModel);
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