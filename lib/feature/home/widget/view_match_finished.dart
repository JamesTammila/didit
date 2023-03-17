import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/model/model_match.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/widget/item_user_matched.dart';
import 'package:didit/feature/home/widget/dialog_post.dart';

class FinishedMatchView extends StatelessWidget {
  const FinishedMatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(context) {
    final bloc = context.read<MatchCubit>();
    return SliverFillRemaining(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Caption: ${matchModel.caption}'),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text('Deadline: ${matchModel.createdAt}'),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: ListView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              itemCount: matchModel.medias.length,
              itemBuilder: (context, i) {
                return MatchedUserItem(
                  userModel: matchModel.medias[i].user,
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          AspectRatio(
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
      ),
    );
  }
}