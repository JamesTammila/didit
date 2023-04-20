import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/account/bloc/cubit_edit.dart';

class PictureSheet extends StatelessWidget {
  const PictureSheet({super.key});

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
              context.read<EditCubit>().changePictureGallery(),
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
              context.read<EditCubit>().changePictureCamera(),
            },
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                children: const [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 15),
                  Text(
                    'Remove Picture',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            onPressed: () => {
              context.pop(),
              context.read<EditCubit>().removePicture(),
            },
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}