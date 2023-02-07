import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(matchModel.theme)),
      body: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            stops: [0, 0.25],
            colors: <Color>[Colors.black, Colors.white],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: ListView(
          cacheExtent: 4,
          children: [
            PostListView(postModel: matchModel.posts[0]),
            PostListView(postModel: matchModel.posts[1]),
            PostListView(postModel: matchModel.posts[2]),
            PostListView(postModel: matchModel.posts[3]),
          ],
        ),
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
                const SizedBox(width: 5),
                MediumPictureView(uri: postModel.user.proPicUri),
                const SizedBox(width: 10),
                Text(postModel.user.username),
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
        CachedNetworkImage(
          fit: BoxFit.fitWidth,
          imageUrl: postModel.mediaUri,
          cacheKey: postModel.mediaUri.split('?')[0],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}