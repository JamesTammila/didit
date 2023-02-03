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
        title: BlocBuilder<ProfilePageCubit, ProfilePageState>(
          builder: (BuildContext context, state) {
            if (state is Loaded) {
              return Text(state.userModel.username);
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: BlocBuilder<ProfilePageCubit, ProfilePageState>(
                builder: (BuildContext context, state) {
                  if (state is Loaded) {
                    return ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                          stops: [0, 0.25],
                          colors: <Color>[Colors.black, Colors.white],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: state.userModel.proPicUri,
                        cacheKey: state.userModel.proPicUri.split('?')[0],
                      ),
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