import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/common/cubit_appsettings.dart';
import 'package:didit/feature/home/widget/item_user_matched.dart';
import 'package:didit/feature/home/widget/dialog_post.dart';
import 'package:didit/feature/home/widget/dialog_permission_post.dart';
import 'package:didit/common/dialog_error.dart';

class UnfinishedMatchView extends StatelessWidget {
  const UnfinishedMatchView({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<MatchCubit>();
    return SliverToBoxAdapter(
      child: BlocConsumer<MatchCubit, MatchState>(
        listener: (BuildContext context, state) {
          if (state is MatchPermission) {
            showDialog(
              context: context,
              builder: (context) => BlocProvider<AppSettingsCubit>(
                create: (context) => AppSettingsCubit(),
                child: const CameraPostDialog(),
              ),
            );
          }
          if (state is MatchFailure) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(error: state.error),
            );
          }
        },
        buildWhen: (previousState, state) {
          if (state is MatchPermission ||
              state is MatchFailure ||
              state is MatchPictureEmpty ||
              state is MatchPicturePreview) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(child: CircularProgressIndicator(strokeWidth: 1));
          } else if (state is MatchLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Caption: ${state.match.caption}'),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Deadline: ${state.match.createdAt}'),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: ListView.builder(
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemCount: state.match.medias.length,
                    itemBuilder: (context, i) {
                      return MatchedUserItem(
                        userModel: state.match.medias[i].user,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      child: BlocBuilder<MatchCubit, MatchState>(
                        buildWhen: (previousState, state) {
                          if (state is MatchPictureEmpty ||
                              state is MatchPicturePreview) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          if (state is MatchPicturePreview) {
                            return Image.file(File(state.path), fit: BoxFit.cover);
                          } else if (state is MatchPictureEmpty) {
                            return Container(
                              color: Colors.grey.shade900,
                              child: const Center(child: Icon(Icons.add)),
                            );
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.read<MatchCubit>().uploadPost(),
                      child: const Text('Post'),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is MatchLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Caption: ${state.match.caption}'),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text('Deadline: ${state.match.createdAt}'),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: ListView.builder(
                    primary: false,
                    padding: EdgeInsets.zero,
                    itemCount: state.match.medias.length,
                    itemBuilder: (context, i) {
                      return MatchedUserItem(
                        userModel: state.match.medias[i].user,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      child: BlocBuilder<MatchCubit, MatchState>(
                        buildWhen: (previousState, state) {
                          if (state is MatchPictureEmpty ||
                              state is MatchPicturePreview) {
                            return true;
                          } else {
                            return false;
                          }
                        },
                        builder: (context, state) {
                          if (state is MatchPicturePreview) {
                            return Image.file(File(state.path), fit: BoxFit.cover);
                          } else if (state is MatchPictureEmpty) {
                            return Container(
                              color: Colors.grey.shade900,
                              child: const Center(child: Icon(Icons.add)),
                            );
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
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.read<MatchCubit>().uploadPost(),
                      child: const Text('Post'),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is MatchError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}