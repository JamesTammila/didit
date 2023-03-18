import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/model/model_match.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/widget/item_user_matched.dart';
import 'package:didit/feature/home/widget/dialog_post.dart';
import 'package:go_router/go_router.dart';

class UnfinishedMatchView extends StatelessWidget {
  const UnfinishedMatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(context) {
    final bloc = context.read<MatchCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(
            height: 100,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: matchModel.medias.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => context.pushNamed('user',
                      extra: matchModel.medias[i].user),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: MatchedUserItem(
                      userModel: matchModel.medias[i].user,
                    ),
                  ),
                );
              },
            ),
          ),
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
                  if (state is MatchUnfinishedEmpty ||
                      state is MatchUnfinishedPreview) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is MatchUnfinishedPreview) {
                    return Image.file(File(state.path), fit: BoxFit.cover);
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
          ListTile(title: Text(matchModel.caption)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('Time Remaining: ${matchModel.createdAt}'),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.read<MatchCubit>().uploadPost(),
                child: const Text('Post'),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}