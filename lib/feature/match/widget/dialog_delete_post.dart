import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/match/bloc/cubit_match.dart';

class DeletePostDialog extends StatelessWidget {
  const DeletePostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Delete Post'),
      content: const Text('Are you sure you want to delete your post? You can '
          'not repost and will be removed from the match.'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          onPressed: () {
            context.pop();
            context.read<MatchCubit>().deletePost();
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