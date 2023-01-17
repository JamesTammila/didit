import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PictureView extends StatelessWidget {
  const PictureView({super.key, required this.uri});

  final String uri;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 20,
      minRadius: 20,
      child: CachedNetworkImage(
        imageUrl: uri,
        cacheKey: uri.toString().split('?')[0],
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            maxRadius: 20,
            minRadius: 20,
            backgroundImage: imageProvider,
          );
        },
        errorWidget: (context, url, error) {
          if (url.isEmpty) {
            return const Icon(Icons.person_rounded, size: 60);
          } else {
            return const Icon(Icons.error, size: 70);
          }
        },
      ),
    );
  }
}