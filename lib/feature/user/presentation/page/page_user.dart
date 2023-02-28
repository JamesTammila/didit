import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/feature/user/domain/bloc/cubit_user.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(context.read<UserCubit>().userModel.username),
        actions: [
          BlocBuilder<UserCubit, UserState>(
            builder: (BuildContext context, state) {
              if (state is UserFriend) {
                return PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: (context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      onTap: () => context.read<UserCubit>().unfriend(),
                      child: const Text('Unfriend'),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
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
                fit: BoxFit.cover,
                imageUrl: context.read<UserCubit>().userModel.proPicUri,
                cacheKey: context.read<UserCubit>().userModel.proPicUri.split('?')[0],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(context.read<UserCubit>().userModel.username),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(context.read<UserCubit>().userModel.bio),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocBuilder<UserCubit, UserState>(
              buildWhen: (previousState, state) {
                if (state is UserRandom || state is UserPending) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (BuildContext context, state) {
                if (state is UserRandom) {
                  return FilledButton(
                    onPressed: () => context.read<UserCubit>().sendRequest(),
                    child: const Text('Add Friend'),
                  );
                } else if (state is UserPending) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Card(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('Pending'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () => context.read<UserCubit>().cancelRequest(),
                        child: const Text('Cancel Request'),
                      ),
                    ],
                  );
                } else if (state is UserWaiting) {
                  return Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () => context.read<UserCubit>().acceptRequest(),
                          child: const Text('Accept'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.read<UserCubit>().rejectRequest(),
                          child: const Text('Reject'),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}