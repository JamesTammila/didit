import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:didit/util/manager_cache.dart';
import 'package:didit/model/model_user.dart';

class LargePictureView extends StatelessWidget {
  const LargePictureView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final String url = userModel.getUrl;
    final String cacheUrl = url.split('?')[0];
    final String firstLetter = userModel.username.substring(0, 1).toUpperCase();
    final int color = int.parse(userModel.color);
    return CircleAvatar(
      maxRadius: 25,
      minRadius: 25,
      child: CachedNetworkImage(
        cacheManager: context.read<CustomCacheManager>(),
        imageUrl: url,
        cacheKey: cacheUrl,
        imageBuilder: (context, imageProvider) {
          return CircleAvatar(
            maxRadius: 25,
            minRadius: 25,
            backgroundImage: imageProvider,
          );
        },
        progressIndicatorBuilder: (context, url, progress) => SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            strokeWidth: 1,
            color: Colors.black,
            value: progress.progress,
          ),
        ),
        errorWidget: (context, url, error) {
          if (url.isEmpty) {
            return CircleAvatar(
              maxRadius: 25,
              minRadius: 25,
              backgroundColor: Color(color),
              foregroundColor: Colors.white,
              child: Text(firstLetter, textAlign: TextAlign.center),
            );
          } else {
            return const Icon(Icons.error, size: 40);
          }
        },
      ),
    );
  }
}