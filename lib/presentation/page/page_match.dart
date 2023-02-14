import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/bloc/cubit_match.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/presentation/widget/view_user.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: BlocBuilder<MatchCubit, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchLoaded) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  title: Text(state.matchModel.theme),
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
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      PostListView(postModel: state.matchModel.posts[state.order[0]]),
                      PostListView(postModel: state.matchModel.posts[state.order[1]]),
                      PostListView(postModel: state.matchModel.posts[state.order[2]]),
                      PostListView(postModel: state.matchModel.posts[state.order[3]]),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
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

class PostListView extends StatelessWidget {
  const PostListView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 10),
                UserView(userModel: postModel.user),
              ],
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => <PopupMenuEntry>[
                const PopupMenuItem(child: Text('Report Post')),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            fit: BoxFit.fitWidth,
            imageUrl: postModel.mediaUri,
            cacheKey: postModel.mediaUri.split('?')[0],
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(value: progress.progress),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}