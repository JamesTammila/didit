import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/domain/bloc/cubit_match.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/presentation/widget/view_picture_small.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MatchView extends StatefulWidget {
  const MatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  MatchViewState createState() => MatchViewState();
}

class MatchViewState extends State<MatchView> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 50,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.matchModel.posts.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () => context.pushNamed('user',
                    extra: widget.matchModel.posts[i].user),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: BlocBuilder<MatchCubit, int>(
                    builder: (context, state) {
                      if (state == i) {
                        return MediumPictureView(
                            uri: widget.matchModel.posts[i].user.proPicUri);
                      } else {
                        return SmallPictureView(
                            uri: widget.matchModel.posts[i].user.proPicUri);
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        BlocBuilder<MatchCubit, int>(
          builder: (context, state) {
            return Text(widget.matchModel.posts[state].user.username);
          },
        ),
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.topRight,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                allowImplicitScrolling: true,
                controller: controller,
                itemCount: widget.matchModel.posts.length,
                onPageChanged: (i) => context.read<MatchCubit>().swipePage(i),
                itemBuilder: (context, i) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.matchModel.posts[i].mediaUri,
                    cacheKey: widget.matchModel.posts[i].mediaUri.split('?')[0],
                    progressIndicatorBuilder: (context, url, progress) => Center(
                      child: CircularProgressIndicator(value: progress.progress),
                    ),
                  );
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: BlocBuilder<MatchCubit, int>(
                  builder: (context, state) {
                    return Text('${state + 1}/${widget.matchModel.posts.length}');
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget.matchModel.theme),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => context
                      .read<MatchesCubit>()
                      .likeMatch(widget.matchModel.objectId),
                  icon: const Icon(Icons.favorite_border),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.chat_bubble_outline),
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () => context
                          .read<MatchesCubit>()
                          .reportPost(widget.matchModel.objectId),
                      child: const Text('Report Post'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}