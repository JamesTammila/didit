import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/account/bloc/cubit_memories.dart';
import 'package:didit/feature/account/widget/dialog_delete_post.dart';

class MemoryItem extends StatelessWidget {
  const MemoryItem({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    final MemoriesCubit bloc = context.read<MemoriesCubit>();
    return InkWell(
      onLongPress: () => showDialog(
        context: context,
        builder: (context) => BlocProvider.value(
          value: bloc,
          child: DeletePostDialog(memory: postModel),
        ),
      ),
      child: Stack(
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
        ],
      ),
    );
  }
}