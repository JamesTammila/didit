import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/presentation/widget/view_picture_small.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key, required this.postModel});

  final PostModel postModel;

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
              PostGridView(postModel: postModel, i: 0),
              PostGridView(postModel: postModel, i: 1),
              PostGridView(postModel: postModel, i: 2),
              PostGridView(postModel: postModel, i: 3),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postModel.theme),
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
  const PostGridView({super.key, required this.postModel, required this.i});

  final PostModel postModel;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => context.pushNamed('match', extra: postModel),
          child: AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: postModel.medias[i].mediaUri,
              cacheKey: postModel.medias[i].mediaUri.split('?')[0],
            ),
          ),
        ),
        Positioned(
          left: 5,
          top: 5,
          child: SmallPictureView(uri: postModel.medias[i].user.proPicUri),
        ),
      ],
    );
  }
}