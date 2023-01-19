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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(model.username),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('Settings'),
            icon: const Icon(Icons.more_vert),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.transparent],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: model.proPicUri,
                cacheKey: model.proPicUri.toString().split('?')[0],
              ),
            ),
          ],
        ),
      ),
    );
  }
}