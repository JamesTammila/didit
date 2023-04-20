import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/widget/button_user_menu.dart';
import 'package:didit/feature/user/widget/button_user_action.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(context) {
    const String errorText = 'Something went wrong...';
    final String username = context.read<UserCubit>().userModel.username;
    final String name = context.read<UserCubit>().userModel.name;
    final String bio = context.read<UserCubit>().userModel.bio;
    final String url = context.read<UserCubit>().userModel.getUrl;
    final int color = int.parse(context.read<UserCubit>().userModel.color);
    final String firstLetter = username.substring(0, 1).toUpperCase();
    final String cachedUrl = url.split('?')[0];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(username),
        actions: const [UserMenuButton()],
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
            aspectRatio: 4 / 5,
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
                imageUrl: url,
                cacheKey: cachedUrl,
                errorWidget: (context, url, error) {
                  if (url.isEmpty) {
                    return Container(
                      color: Color(color),
                      alignment: Alignment.center,
                      child: Text(
                        firstLetter,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 50),
                      ),
                    );
                  } else {
                    return const Center(child: Text(errorText));
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: name.isEmpty ? const SizedBox() : Text(name),
          ),
          SizedBox(height: name.isEmpty || bio.isEmpty ? 0 : 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: bio.isEmpty ? const SizedBox() : Text(bio),
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