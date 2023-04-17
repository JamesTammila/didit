import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/model/model_user.dart';

class MatchedUserItem extends StatelessWidget {
  const MatchedUserItem({super.key, required this.i, required this.userModel});

  final int i;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: i < 2 ? Alignment.topCenter : Alignment.bottomCenter,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            cacheManager: context.read<CustomCacheManager>(),
            fit: BoxFit.cover,
            imageUrl: userModel.getUrl,
            cacheKey: userModel.getUrl.split('?')[0],
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                value: progress.progress,
              ),
            ),
            errorWidget: (context, url, error) {
              if (url.isEmpty) {
                return Container(
                  color: Color(int.parse(userModel.color)),
                  alignment: Alignment.center,
                  child: Text(
                    userModel.username.substring(0, 1).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 50),
                  ),
                );
              } else {
                return const Center(
                    child: Text('Something went wrong...'));
              }
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: i < 2 ? Alignment.topCenter : Alignment.bottomCenter,
              end: i < 2 ? Alignment.bottomCenter : Alignment.topCenter,
              colors: const <Color>[Colors.black, Colors.transparent],
            ),
          ),
          child: ListTile(
            title: Text(userModel.username, textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}