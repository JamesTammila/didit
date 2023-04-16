import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/match/bloc/cubit_timer.dart';
import 'package:didit/feature/match/widget/item_user_matched.dart';

class PartialMatchView extends StatelessWidget {
  const PartialMatchView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(context) {
    final Duration timeRemaining = DateTime.parse(data['match'].createdAt)
        .add(const Duration(hours: 1))
        .difference(DateTime.now());
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const SizedBox(height: 20),
          BlocProvider<TimerCubit>(
            create: (_) => TimerCubit(timeRemaining)..init(),
            child: BlocBuilder<TimerCubit, Duration>(
              builder: (context, state) {
                int minutes = state.inMinutes;
                int seconds = state.inSeconds % 60;
                return Center(
                  child: Text(
                    "$minutes:${seconds.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontSize: 30),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: data['match'].medias.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                  ),
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () => context.pushNamed('user',
                          extra: data['match'].medias[i].user),
                      child: MatchedUserItem(
                        i: i,
                        userModel: data['match'].medias[i].user,
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        data['match'].caption,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
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