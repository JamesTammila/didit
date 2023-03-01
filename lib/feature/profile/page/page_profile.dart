import 'package:didit/common/dialog_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/feature/profile/bloc/cubit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (BuildContext context, state) {
            if (state is ProfileLoaded) {
              return Text(state.userModel.username);
            } else {
              return const SizedBox();
            }
          },
        ),
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
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (BuildContext context, state) {
                  if (state is ProfileLoaded) {
                    return ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          stops: [0, 0.1],
                          colors: <Color>[Colors.black, Colors.white],
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
            const SizedBox(height: 20),
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (BuildContext context, state) {
                if (state is ProfileLoaded) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.userModel.username),
                        const SizedBox(height: 20),
                        Text(state.userModel.bio),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: InkWell(
                  onTap: () => context.pushNamed('edit'),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: const [
                        SizedBox(width: 10),
                        Icon(Icons.edit),
                        SizedBox(width: 10),
                        Text('Edit Profile'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('Settings'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => context.pushNamed('matching'),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.favorite),
                            SizedBox(width: 10),
                            Text('Matching'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => context.pushNamed('notifications'),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.notifications),
                            SizedBox(width: 10),
                            Text('Notifications'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => context.pushNamed('privacy'),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.remove_red_eye),
                            SizedBox(width: 10),
                            Text('Privacy'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => context.pushNamed('other'),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.settings),
                            SizedBox(width: 10),
                            Text('Other'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('About'),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => context.read<ProfileCubit>().shareLink(),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.share),
                            SizedBox(width: 10),
                            Text('Share didit'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => const SoonDialog(),
                      ),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.star_rate),
                            SizedBox(width: 10),
                            Text('Rate didit'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => context.pushNamed('help'),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.help),
                            SizedBox(width: 10),
                            Text('Help'),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () => context.pushNamed('about'),
                      child: SizedBox(
                        height: 50,
                        child: Row(
                          children: const [
                            SizedBox(width: 10),
                            Icon(Icons.info),
                            SizedBox(width: 10),
                            Text('About'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                child: BlocListener<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is ProfileExit) {
                      context.pop();
                      context.pushReplacementNamed('auth');
                    }
                  },
                  child: InkWell(
                    onTap: () => context.read<ProfileCubit>().logout(),
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
          ],
        ),
      ),
    );
  }
}