import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/src/domain/model/model_user.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.model});

  final UserModel model;

  @override
  Widget build(context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(250),
        child: AppBar(
          centerTitle: false,
          title: Text(model.username),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(10),
            title: Text(model.username),
            background: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: model.proPicUri,
              cacheKey: model.proPicUri.toString().split('?')[0],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed('Settings'),
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }
}