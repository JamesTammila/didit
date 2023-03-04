import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MediumPictureView extends StatelessWidget {
  const MediumPictureView({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 21,
      minRadius: 21,
      child: CachedNetworkImage(
        imageUrl: url,
        cacheKey: url.split('?')[0],
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            maxRadius: 20,
            minRadius: 20,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) => SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            color: Colors.black,
            value: progress.progress,
          ),
        ),
        errorWidget: (context, url, error) {
          if (url.isEmpty) {
            return const Icon(Icons.person_rounded, size: 30);
          } else {
            return const Icon(Icons.error, size: 30);
          }
        },
      ),
    );
  }
}