import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/bloc/cubit_timer.dart';
import 'package:didit/feature/home/widget/item_user_matched.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<MatchCubit, MatchState>(
      builder: (context, state) {
        if (state is MatchLoading) {
          return const SizedBox(
            child: AspectRatio(
              aspectRatio: 1,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
          );
        } else if (state is MatchLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              BlocProvider<TimerCubit>(
                create: (_) => TimerCubit(
                  state.match.createdAt,
                  () => context.read<MatchCubit>().clearMatch(),
                )..init(),
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
              ListTile(
                title: Text(
                  state.match.caption,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: state.match.medias.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1,
                      crossAxisSpacing: 1,
                    ),
                    itemBuilder: (context, i) {
                      return MatchedUserItem(
                        userModel: state.match.medias[i].user,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child: FilledButton(
                  onPressed: () => context.pushNamed('post'),
                  child: const Text('Post'),
                ),
              ),
            ],
          );
        } else if (state is MatchError) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Center(
                child: Text(
                  state.error,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}