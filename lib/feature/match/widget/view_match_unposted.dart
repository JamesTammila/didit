import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/feature/match/bloc/cubit_match.dart';
import 'package:didit/feature/match/bloc/cubit_timer.dart';
import 'package:didit/feature/match/widget/item_user_matched.dart';
import 'package:didit/feature/match/widget/dialog_post.dart';

class UnpostedMatchView extends StatelessWidget {
  const UnpostedMatchView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(context) {
    final bloc = context.read<MatchCubit>();
    final Duration timeRemaining = DateTime.parse(postModel.createdAt)
        .add(const Duration(hours: 1))
        .difference(DateTime.now());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const SizedBox(height: 20),
          BlocProvider<TimerCubit>(
            create: (_) => TimerCubit(timeRemaining)..init(),
            child: BlocBuilder<TimerCubit, Duration>(
              builder: (context, state) {
                int minutes = state.inMinutes;
                int seconds = state.inSeconds % 60;
                return Center(
                  child: Text(
                    "$minutes:${seconds.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 30),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: postModel.medias.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () => context.pushNamed('user', extra: postModel.medias[i].user),
                      child: MatchedUserItem(
                        i: i,
                        userModel: postModel.medias[i].user,
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        postModel.caption,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          AspectRatio(
            aspectRatio: 1,
            child: BlocBuilder<MatchCubit, MatchState>(
              buildWhen: (previousState, state) {
                if (state is MatchUnposted ||
                    state is MatchUnpostedPreview) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is MatchUnpostedPreview) {
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
                 );                }
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<MatchCubit, MatchState>(
            buildWhen: (previousState, state) {
              if (state is MatchUnposted || state is MatchUnpostedPreview) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if (state is MatchUnposted || state is MatchUnpostedPreview) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.read<MatchCubit>().uploadPost(),
                      child: const Text('Post'),
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