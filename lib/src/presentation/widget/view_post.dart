import 'package:didit/src/domain/model/model_post.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: postModel.mediaUri,
        cacheKey: postModel.mediaUri.toString().split('?')[0],
      ),
    );
  }
}