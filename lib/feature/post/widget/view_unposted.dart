import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/feature/home/bloc/cubit_timer.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';
import 'package:didit/feature/post/widget/dialog_post.dart';

class UnpostedView extends StatelessWidget {
  const UnpostedView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(context) {
    final bloc = context.read<PostCubit>();
    final Duration timeRemaining = DateTime.parse(postModel.createdAt)
        .add(const Duration(minutes: 3))
        .difference(DateTime.now());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 10),
          ListTile(
            leading: const SizedBox(width: 48),
            title: Text(
              postModel.caption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
            trailing: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close),
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: BlocProvider<TimerCubit>(
              create: (_) => TimerCubit(
                timeRemaining,
                    () => {},
              )..init(),
              child: BlocBuilder<TimerCubit, Duration>(
                builder: (context, state) {
                  int minutes = state.inMinutes;
                  int seconds = state.inSeconds % 60;
                  return Text(
                    "$minutes:${seconds.toString().padLeft(2, '0')}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 30),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
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
                  child: FilledButton(
                    onPressed: () => context.read<PostCubit>().uploadPost(),
                    child: const Text('Upload'),
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