import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/feature/account/bloc/cubit_memories_page.dart';

class DeletePostDialog extends StatelessWidget {
  const DeletePostDialog({super.key, required this.memory});

  final PostModel memory;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Delete Post'),
      content: const Text('Are you sure you want to delete your post? Only '
          'your photo will be deleted and the post will be removed from your '
          'memories.'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('DELETE', style: TextStyle(color: Colors.red)),
          onPressed: () {
            context.pop();
            context.read<MemoriesPageCubit>().deleteMemory(memory);
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