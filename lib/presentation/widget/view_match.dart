import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(matchModel.theme)),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: Center(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: matchModel.posts.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => context.pushNamed('user', extra: matchModel.posts[i].user),
                  child: MediumPictureView(uri: matchModel.posts[i].user.proPicUri),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 10),
        AspectRatio(
          aspectRatio: 1,
          child: PageView.builder(
            itemCount: matchModel.posts.length,
            itemBuilder: (context, i) {
              return CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: matchModel.posts[i].mediaUri,
                cacheKey: matchModel.posts[i].mediaUri.split('?')[0],
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
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.favorite_border),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () => {},
                  child: const Text('Report Post'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}