import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';

class PostDialog extends StatelessWidget {
  const PostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Photo Library'),
            onPressed: () => {
              context.pop(),
              context.read<PostCubit>().takePostGallery(),
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Camera'),
            onPressed: () => {
              context.pop(),
              context.read<PostCubit>().takePostCamera(),
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}