import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/home/bloc/cubit_timer.dart';

class PostedView extends StatelessWidget {
  const PostedView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  Widget build(context) {
    final Duration timeRemaining = DateTime.parse(data['match'].createdAt)
        .add(const Duration(minutes: 3))
        .difference(DateTime.now());
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 19),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 48),
              BlocProvider<TimerCubit>(
                create: (_) => TimerCubit(
                  timeRemaining,
                      () => {},
                )..init(),
                child: BlocBuilder<TimerCubit, Duration>(
                  builder: (context, state) {
                    int minutes = state.inMinutes;
                    int seconds = state.inSeconds % 60;
                    return Text(
                      "$minutes:${seconds.toString().padLeft(2, '0')}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 30),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          ListTile(
            title: Text(
              data['match'].caption,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20),
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
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}