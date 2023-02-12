import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_match_current.dart';
import 'package:didit/presentation/widget/view_user_matched.dart';
import 'package:didit/presentation/widget/dialog_post.dart';

class CurrentMatchSheet extends StatelessWidget {
  const CurrentMatchSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CurrentMatchCubit>();
    return SizedBox(
      height: 470,
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Card(child: SizedBox(height: 5, width: 50)),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<CurrentMatchCubit, CurrentMatchState>(
              builder: (context, state) {
                if (state is CurrentMatchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CurrentMatchLoaded) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(state.currentMatch.theme),
                            Text('Deadline: ${state.currentMatch.createdAt}'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MatchedUserView(
                        userModel: state.currentMatch.posts[0].user,
                      ),
                      const SizedBox(height: 10),
                      MatchedUserView(
                        userModel: state.currentMatch.posts[1].user,
                      ),
                      const SizedBox(height: 10),
                      MatchedUserView(
                        userModel: state.currentMatch.posts[2].user,
                      ),
                      const SizedBox(height: 10),
                      MatchedUserView(
                        userModel: state.currentMatch.posts[3].user,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => BlocProvider.value(
                                value: bloc,
                                child: const PostDialog(),
                              ),
                            ),
                            child: const Text('Post'),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is CurrentMatchEmpty) {
                  return const Center(child: Text("No Match"));
                } else if (state is CurrentMatchError) {
                  return Center(child: Text(state.error));
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}