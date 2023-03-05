import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';

class SmallPictureView extends StatelessWidget {
  const SmallPictureView({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 15,
      minRadius: 15,
      child: CachedNetworkImage(
        cacheManager: CustomCacheManager.instance,
        imageUrl: url,
        cacheKey: url.split('?')[0],
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            maxRadius: 15,
            minRadius: 15,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) => SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: Colors.black,
            value: progress.progress,
          ),
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