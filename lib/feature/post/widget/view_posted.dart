import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';

class PostedView extends StatelessWidget {
  const PostedView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + 10),
          AspectRatio(
            aspectRatio: 1,
            child: CachedNetworkImage(
              cacheManager: context.read<CustomCacheManager>(),
              fit: BoxFit.cover,
              imageUrl: data['url'],
              cacheKey: data['url'].split('?')[0],
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
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
