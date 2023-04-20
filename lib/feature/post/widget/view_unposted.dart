import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/feature/home/bloc/cubit_timer.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';
import 'package:didit/feature/post/widget/sheet_posting.dart';

class UnpostedView extends StatelessWidget {
  const UnpostedView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(context) {
    final bloc = context.read<PostCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 20),
          BlocProvider<TimerCubit>(
            create: (_) => TimerCubit(
              postModel.createdAt,
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
          ListTile(
            title: Text(
              postModel.caption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
              aspectRatio: 4 / 5,
              child: GestureDetector(
                onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: const PostingSheet(),
                  ),
                ),
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
                      return Image.file(
                        File(state.path),
                        fit: BoxFit.cover,
                      );
                    } else {
                      return Container(
                        color: Colors.grey.shade900,
                        child: const Center(child: Icon(Icons.add, size: 50)),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
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
                  padding: const EdgeInsets.all(25),
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