import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/src/domain/model/model_post.dart';
import 'package:didit/src/presentation/widget/view_picture.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                PictureView(uri: postModel.task.sender.proPicUri),
                const SizedBox(width: 5),
                Text(postModel.task.sender.username),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_right_alt),
                const SizedBox(width: 5),
                PictureView(uri: postModel.task.receiver.proPicUri),
                const SizedBox(width: 5),
                Text(postModel.task.receiver.username),
              ],
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Text(postModel.task.message),
        ),
        const SizedBox(height: 10),
        Card(
          child: InteractiveViewer(
            panEnabled: false,
            child: AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: postModel.mediaUri,
                cacheKey: postModel.mediaUri.toString().split('?')[0],
              ),
            ),
          ),
        ),
      ],
    );
  }
}