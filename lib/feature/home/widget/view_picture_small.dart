import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SmallPictureView extends StatelessWidget {
  const SmallPictureView({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 15,
      minRadius: 15,
      child: CachedNetworkImage(
        imageUrl: uri,
        cacheKey: uri.split('?')[0],
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            maxRadius: 15,
            minRadius: 15,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(value: progress.progress),
        ),
        errorWidget: (context, url, error) {
          if (url.isEmpty) {
            return const Icon(Icons.person_rounded, size: 20);
          } else {
            return const Icon(Icons.error, size: 20);
          }
        },
      ),
    );
  }
}