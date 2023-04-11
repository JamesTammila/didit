import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/util/formatter_month.dart';

class MemoryGridItem extends StatelessWidget {
  const MemoryGridItem({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            cacheManager: context.read<CustomCacheManager>(),
            fit: BoxFit.cover,
            imageUrl: postModel.medias[0].getUrl,
            cacheKey: postModel.medias[0].getUrl.split('?')[0],
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                value: progress.progress,
              ),
            ),
            errorWidget: (context, url, error) =>
                const Center(child: Text('Something went wrong...')),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5))],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateTime.parse(postModel.createdAt).day.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              formatMonth(DateTime.parse(postModel.createdAt).month),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }
}