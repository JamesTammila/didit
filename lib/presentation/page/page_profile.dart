import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/bloc/cubit_page_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.read<ProfilePageCubit>().userModel.username),
        actions: [
          BlocBuilder<ProfilePageCubit, ProfilePageState>(
            builder: (BuildContext context, state) {
              if (state is Me) {
                return IconButton(
                  onPressed: () => context.pushNamed('Settings'),
                  icon: const Icon(Icons.more_vert),
                );
              } else if (state is Friend) {
                return PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    const PopupMenuItem(child: Text('Report Post')),
                    const PopupMenuItem(child: Text('Block User')),
                    const PopupMenuItem(child: Text('Unfriend')),
                  ],
                );
              } else {
                return PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    const PopupMenuItem(child: Text('Report Post')),
                    const PopupMenuItem(child: Text('Block User')),
                  ],
                );
              }
            },
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: context.read<ProfilePageCubit>().userModel.proPicUri,
                cacheKey: context.read<ProfilePageCubit>().userModel.proPicUri
                    .toString().split('?')[0],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (BuildContext context, state) {
                  if (state is Random) {
                    return FilledButton(
                      onPressed: () => {},
                      child: const Text('Add Friend'),
                    );
                  } else if (state is Pending) {
                    return FilledButton(
                      onPressed: () => {},
                      child: const Text('Pending'),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}