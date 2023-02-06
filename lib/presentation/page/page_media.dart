import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_media.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MediaPage extends StatelessWidget {
  const MediaPage({super.key, required this.mediaModel});

  final MediaModel mediaModel;

  @override
  Widget build(context) {
    return Hero(
      tag: mediaModel.objectId,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(width: 10),
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
            InkWell(
              onTap: () => context.pop(),
              child: AspectRatio(
                aspectRatio: 4 / 5,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: mediaModel.mediaUri,
                  cacheKey: mediaModel.mediaUri.split('?')[0],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}