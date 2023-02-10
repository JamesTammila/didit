import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_match_current.dart';
import 'package:didit/presentation/widget/view_user.dart';
import 'package:didit/presentation/widget/dialog_post.dart';

class CurrentMatchView extends StatelessWidget {
  const CurrentMatchView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CurrentMatchCubit>();
    return SizedBox(
      height: 400,
      child: Card(
        margin: const EdgeInsets.all(15),
        child: BlocBuilder<CurrentMatchCubit, CurrentMatchState>(
          builder: (context, state) {
            if (state is CurrentMatchLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CurrentMatchLoaded) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(state.currentMatch.theme),
                        Text(state.currentMatch.createdAt),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserView(userModel: state.currentMatch.posts[0].user),
                        const Icon(Icons.access_time_filled, color: Colors.yellow),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserView(userModel: state.currentMatch.posts[1].user),
                        const Icon(Icons.access_time_filled, color: Colors.yellow),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserView(userModel: state.currentMatch.posts[2].user),
                        const Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        UserView(userModel: state.currentMatch.posts[3].user),
                        const Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FloatingActionButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) => BlocProvider.value(
                          value: bloc,
                          child: const PostDialog(),
                        ),
                      ),
                      child: const Text('Post'),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
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
    );
  }
}