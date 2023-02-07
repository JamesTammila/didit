import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_match.dart';
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
            primary: false,
            crossAxisCount: 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            children: <Widget>[
              PostGridView(matchModel: matchModel, i: 0),
              PostGridView(matchModel: matchModel, i: 1),
              PostGridView(matchModel: matchModel, i: 2),
              PostGridView(matchModel: matchModel, i: 3),
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
  const PostGridView({super.key, required this.matchModel, required this.i});

  final MatchModel matchModel;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => context.pushNamed('match', extra: matchModel),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: matchModel.posts[i].mediaUri,
              cacheKey: matchModel.posts[i].mediaUri.split('?')[0],
            ),
          ),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: SmallPictureView(uri: matchModel.posts[i].user.proPicUri),
        ),
      ],
    );
  }
}