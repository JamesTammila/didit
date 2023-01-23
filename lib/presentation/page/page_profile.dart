import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/bloc/cubit_page_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(context) {
    //final username = context.select((ProfilePageCubit c) => c.userModel.username);
    final username = context.read<ProfilePageCubit>().userModel.username;
    final proPicUri = context.read<ProfilePageCubit>().userModel.proPicUri;
    final cacheKey = proPicUri.toString().split('?')[0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(username),
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
                imageUrl: proPicUri,
                cacheKey: cacheKey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}