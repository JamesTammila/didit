import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/feature/search/bloc/cubit_item_filter_friend.dart';
import 'package:didit/common/dialog_error.dart';

class UnfriendFilterDialog extends StatelessWidget {
  const UnfriendFilterDialog({super.key, required this.friendModel});

  final FriendModel friendModel;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Unfriend User'),
      content: const Text('Are you sure you want to unfriend this person?'),
      actions: <Widget>[
        BlocListener<FriendFilterItemCubit, FriendFilterItemState>(
          listener: (context, state) {
            if (state is FriendFilterItemError) {
              showDialog(
                context: context,
                builder: (context) => ErrorDialog(error: state.error),
              );
            }
          },
          child: CupertinoButton(
            child: const Text('YES', style: TextStyle(color: Colors.red)),
            onPressed: () {
              context.read<FriendFilterItemCubit>().unfriendUser(friendModel);
              context.pop();
            },
          ),
        ),
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => context.pop(),
        ),
      ],
    );
  }
}