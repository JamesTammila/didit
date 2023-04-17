import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';
import 'package:didit/feature/post/widget/dialog_post.dart';

class UnpostedView extends StatelessWidget {
  const UnpostedView({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<PostCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 10),
          AspectRatio(
            aspectRatio: 1,
            child: BlocBuilder<PostCubit, PostState>(
              buildWhen: (previousState, state) {
                if (state is PostEmpty || state is PostPreview) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is PostPreview) {
                  return InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: bloc,
                        child: const PostDialog(),
                      ),
                    ),
                    child: Image.file(
                      File(state.path),
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return InkWell(
                    onTap: () => showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: bloc,
                        child: const PostDialog(),
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        color: Colors.grey.shade900,
                        child: const Center(child: Icon(Icons.add)),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<PostCubit, PostState>(
            buildWhen: (previousState, state) {
              if (state is PostEmpty || state is PostPreview) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is PostEmpty || state is PostPreview) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.read<PostCubit>().uploadPost(),
                      child: const Text('Upload'),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}