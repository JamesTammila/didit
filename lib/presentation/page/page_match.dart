import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/domain/model/model_media.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(postModel.theme)),
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
          children: [
            PostListView(mediaModel: postModel.medias[0]),
            PostListView(mediaModel: postModel.medias[1]),
            PostListView(mediaModel: postModel.medias[2]),
            PostListView(mediaModel: postModel.medias[3]),
          ],
        ),
      ),
    );
  }
}


class PostListView extends StatelessWidget {
  const PostListView({super.key, required this.mediaModel});

  final MediaModel mediaModel;

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
                MediumPictureView(uri: mediaModel.user.proPicUri),
                const SizedBox(width: 10),
                Text(mediaModel.user.username),
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
          imageUrl: mediaModel.mediaUri,
          cacheKey: mediaModel.mediaUri.split('?')[0],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}