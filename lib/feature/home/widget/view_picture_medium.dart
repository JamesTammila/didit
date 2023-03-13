import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/model/model_user.dart';

class MediumPictureView extends StatelessWidget {
  const MediumPictureView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 21,
      minRadius: 21,
      child: CachedNetworkImage(
        cacheManager: context.read<CustomCacheManager>(),
        imageUrl: userModel.getUrl,
        cacheKey: userModel.getUrl.split('?')[0],
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
            strokeWidth: 1,
            color: Colors.black,
            value: progress.progress,
          ),
        ),
        errorWidget: (context, url, error) {
          if (url.isEmpty) {
            return CircleAvatar(
              maxRadius: 20,
              minRadius: 20,
              backgroundColor: Color(userModel.color),
              foregroundColor: Colors.white,
              child: Text(
                userModel.username.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return const Icon(Icons.error, size: 30);
          }
        },
      ),
    );
  }
}