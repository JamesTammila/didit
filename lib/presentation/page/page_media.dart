import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_media.dart';
import 'package:didit/presentation/widget/view_picture.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key, required this.mediaModel});

  final MediaModel mediaModel;

  @override
  Widget build(context) {
    return Scaffold(
      body: Hero(
        tag: mediaModel.objectId,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
                    PictureView(uri: mediaModel.user.proPicUri),
                    const SizedBox(width: 10),
                    Text(mediaModel.user.username),
                  ],
                ),
                IconButton(
                  onPressed: () => {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Card(
              child: InkWell(
                onTap: () => context.pop(),
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: mediaModel.mediaUri,
                    cacheKey: mediaModel.mediaUri.toString().split('?')[0],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}