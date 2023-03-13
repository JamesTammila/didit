import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/widget/menu_user_action.dart';
import 'package:didit/feature/user/widget/button_user_action.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.read<UserCubit>().userModel.username),
        actions: const [UserActionMenu()],
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  stops: [0, 0.1],
                  colors: <Color>[Colors.black, Colors.white],
                ).createShader(bounds);
              },
              child: CachedNetworkImage(
                cacheManager: context.read<CustomCacheManager>(),
                fit: BoxFit.cover,
                imageUrl: context.read<UserCubit>().userModel.getUrl,
                cacheKey:
                    context.read<UserCubit>().userModel.getUrl.split('?')[0],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              context.read<UserCubit>().userModel.name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(context.read<UserCubit>().userModel.bio),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: UserActionButton(),
          ),
        ],
      ),
    );
  }
}