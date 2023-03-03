import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/account/bloc/cubit_edit.dart';

class PictureDialog extends StatelessWidget {
  const PictureDialog({super.key});

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
              context.read<EditCubit>().changePictureGallery(),
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text('Camera'),
            onPressed: () => {
              context.pop(),
              context.read<EditCubit>().changePictureCamera(),
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            child: const Text(
              'Remove Picture',
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => {
              context.pop(),
              context.read<EditCubit>().removePicture(),
            },
          ),
        ],
      ),
    );
  }
}
