import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';

class PostingSheet extends StatelessWidget {
  const PostingSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom + 10;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: const [
                  Icon(Icons.photo_size_select_actual),
                  SizedBox(width: 15),
                  Text('Photo Library'),
                ],
              ),
            ),
            onPressed: () => {
              context.pop(),
              context.read<PostCubit>().takePostGallery(),
            },
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: const [
                  Icon(Icons.camera_alt_rounded),
                  SizedBox(width: 15),
                  Text('Camera'),
                ],
              ),
            ),
            onPressed: () => {
              context.pop(),
              context.read<PostCubit>().takePostCamera(),
            },
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}