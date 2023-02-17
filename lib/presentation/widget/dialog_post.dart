import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/bloc/cubit_match_current.dart';

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
            child: const Text("Photo Library"),
            onPressed: () => {
              context.pop(),
              context.read<CurrentMatchCubit>().takePostGallery(),
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text("Camera"),
            onPressed: () => {
              context.pop(),
              context.read<CurrentMatchCubit>().takePostCamera(),
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text(
              "Clear Post",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => {
              context.pop(),
              context.read<CurrentMatchCubit>().removePost(),
            },
          ),
        ],
      ),
    );
  }
}