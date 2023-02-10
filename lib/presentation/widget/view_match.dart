import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/presentation/widget/view_picture_small.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: GridView.count(
            padding: EdgeInsets.zero,
            primary: false,
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children: <Widget>[
              InkWell(
                onTap: () => context.pushNamed('match', extra: [0, matchModel]),
                child: PostGridView(postModel: matchModel.posts[0]),
              ),
              InkWell(
                onTap: () => context.pushNamed('match', extra: [1, matchModel]),
                child: PostGridView(postModel: matchModel.posts[1]),
              ),
              InkWell(
                onTap: () => context.pushNamed('match', extra: [2, matchModel]),
                child: PostGridView(postModel: matchModel.posts[2]),
              ),
              InkWell(
                onTap: () => context.pushNamed('match', extra: [3, matchModel]),
                child: PostGridView(postModel: matchModel.posts[3]),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(matchModel.theme),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}

class PostGridView extends StatelessWidget {
  const PostGridView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: postModel.mediaUri,
            cacheKey: postModel.mediaUri.split('?')[0],
          ),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: InkWell(
            onTap: () => context.pushNamed('user', extra: postModel.user),
            child: SmallPictureView(uri: postModel.user.proPicUri),
          ),
        ),
      ],
    );
  }
}