import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/common/cubit_appsettings.dart';
import 'package:didit/feature/home/widget/view_user_matched.dart';
import 'package:didit/feature/home/widget/dialog_post.dart';
import 'package:didit/feature/home/widget/dialog_permission_post.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<MatchCubit>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Match'),
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
              height: 400,
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
                },
                buildWhen: (previousState, state) {
                  if (state is MatchPermission ||
                      state is MatchFailure ||
                      state is MatchPictureEmpty ||
                      state is MatchPicturePreview ||
                      state is MatchPictureError) {
                    return false;
                  } else {
                    return true;
                  }
                },
                builder: (context, state) {
                  if (state is MatchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MatchLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('Theme: ${state.match.theme}'),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child:
                              Text('Deadline: ${state.match.createdAt}'),
                        ),
                        const SizedBox(height: 10),
                        Flexible(
                          child: ListView.builder(
                            primary: false,
                            padding: EdgeInsets.zero,
                            itemCount: state.match.medias.length,
                            itemBuilder: (context, i) {
                              return MatchedUserView(
                                userModel: state.match.medias[i].user,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  } else if (state is MatchEmpty) {
                    return const Center(child: Text("No Match"));
                  } else if (state is MatchError) {
                    return Center(child: Text(state.error));
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
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
                          state is MatchPicturePreview ||
                          state is MatchPictureError) {
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
                      } else if (state is MatchPictureError) {
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
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
          ],
        ),
      ),
    );
  }
}