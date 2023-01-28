import 'package:flutter/material.dart';
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
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(matchModel.theme),
              Row(
                children: [
                  SmallPictureView(uri: matchModel.posts[0].user.proPicUri),
                  const SizedBox(width: 5),
                  SmallPictureView(uri: matchModel.posts[1].user.proPicUri),
                  const SizedBox(width: 5),
                  SmallPictureView(uri: matchModel.posts[2].user.proPicUri),
                  const SizedBox(width: 5),
                  SmallPictureView(uri: matchModel.posts[3].user.proPicUri),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Card(
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: GridView.count(
              primary: false,
              childAspectRatio: 4 / 5,
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: <Widget>[
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: matchModel.posts[0].mediaUri,
                  cacheKey: matchModel.posts[0].mediaUri.toString().split('?')[0],
                ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: matchModel.posts[1].mediaUri,
                  cacheKey: matchModel.posts[1].mediaUri.toString().split('?')[0],
                ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: matchModel.posts[2].mediaUri,
                  cacheKey: matchModel.posts[2].mediaUri.toString().split('?')[0],
                ),
                CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: matchModel.posts[3].mediaUri,
                  cacheKey: matchModel.posts[3].mediaUri.toString().split('?')[0],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}