import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/match/widget/item_user_matched.dart';
import 'package:go_router/go_router.dart';

class PartialMatchView extends StatelessWidget {
  const PartialMatchView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          SizedBox(
            height: 100,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data['match'].medias.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => context.pushNamed('user',
                      extra: data['match'].medias[i].user),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: MatchedUserItem(
                      userModel: data['match'].medias[i].user,
                    ),
                  ),
                );
              },
            ),
          ),
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
          ListTile(title: Text(data['match'].caption)),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
                'Time Remaining: ${DateTime.parse(data['match'].createdAt).add(const Duration(hours: 5)).difference(DateTime.now()).toString().split('.')[0]}'),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}