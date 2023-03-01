import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LargePictureView extends StatelessWidget {
  const LargePictureView({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 25,
      minRadius: 25,
      child: CachedNetworkImage(
        imageUrl: uri,
        cacheKey: uri.split('?')[0],
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            maxRadius: 25,
            minRadius: 25,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(value: progress.progress),
        ),
        errorWidget: (context, url, error) {
          if (url.isEmpty) {
            return const Icon(Icons.person_rounded, size: 40);
          } else {
            return const Icon(Icons.error, size: 40);
          }
        },
      ),
    );
  }
}