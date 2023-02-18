import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/domain/model/model_match.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                height: 50,
                child: Center(
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.matchModel.posts.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () => context.pushNamed('user',
                            extra: widget.matchModel.posts[i].user),
                        child: MediumPictureView(
                            uri: widget.matchModel.posts[i].user.proPicUri),
                      );
                    },
                  ),
                ),
              ),
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
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            controller: controller,
            itemCount: widget.matchModel.posts.length,
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
        const SizedBox(height: 10),
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
                  icon: const Icon(Icons.wechat_rounded),
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