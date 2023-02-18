import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_match_current.dart';
import 'package:didit/presentation/widget/view_user_matched.dart';
import 'package:didit/presentation/widget/dialog_post.dart';
import 'package:didit/presentation/widget/dialog_permission_post.dart';

class CurrentMatchPage extends StatelessWidget {
  const CurrentMatchPage({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<CurrentMatchCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Current Match'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: TextButton(
              onPressed: () => {},
              child: const Text(
                'Leave Match',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.transparent],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                height: MediaQuery.of(context).padding.top + kToolbarHeight),
            SizedBox(
              height: 420,
              child: BlocConsumer<CurrentMatchCubit, CurrentMatchState>(
                listener: (BuildContext context, state) {
                  if (state is CurrentMatchPermission) {
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider.value(
                        value: bloc,
                        child: const CameraPostDialog(),
                      ),
                    );
                  }
                },
                buildWhen: (previousState, state) {
                  if (state is CurrentMatchPermission ||
                      state is CurrentMatchFailure ||
                      state is CurrentMatchPictureEmpty ||
                      state is CurrentMatchPicturePreview ||
                      state is CurrentMatchPictureError) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state is CurrentMatchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CurrentMatchLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text('Theme: ${state.currentMatch.theme}'),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:
                              Text('Deadline: ${state.currentMatch.createdAt}'),
                        ),
                        const SizedBox(height: 20),
                        MatchedUserView(
                          userModel: state.currentMatch.posts[0].user,
                        ),
                        MatchedUserView(
                          userModel: state.currentMatch.posts[1].user,
                        ),
                        MatchedUserView(
                          userModel: state.currentMatch.posts[2].user,
                        ),
                        MatchedUserView(
                          userModel: state.currentMatch.posts[3].user,
                        ),
                        const SizedBox(height: 20),
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
            Padding(
              padding: const EdgeInsets.all(15),
              child: AspectRatio(
                aspectRatio: 1,
                child: InkWell(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: const PostDialog(),
                    ),
                  ),
                  child: BlocBuilder<CurrentMatchCubit, CurrentMatchState>(
                    buildWhen: (previousState, state) {
                      if (state is CurrentMatchPictureEmpty ||
                          state is CurrentMatchPicturePreview ||
                          state is CurrentMatchPictureError) {
                        return true;
                      } else {
                        return false;
                      }
                    },
                    builder: (context, state) {
                      if (state is CurrentMatchPicturePreview) {
                        return Image.file(File(state.path));
                      } else if (state is CurrentMatchPictureEmpty) {
                        return Container(
                          color: Colors.grey.shade900,
                          child: const Center(child: Icon(Icons.add)),
                        );
                      } else if (state is CurrentMatchPictureError) {
                        return Center(child: Text(state.error));
                      } else {
                        return AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: Colors.grey.shade900,
                            child: const Center(child: Icon(Icons.add)),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () =>
                      context.read<CurrentMatchCubit>().uploadPost(),
                  child: const Text('Post'),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
          ],
        ),
      ),
    );
  }
}