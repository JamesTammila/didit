import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/domain/bloc/cubit_posts.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_post.dart';
import 'package:didit/presentation/widget/dialog_match.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    FlutterNativeSplash.remove();
    return BlocListener<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsDenied) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Notification Permission"),
              content: const Text("We need to request your permission to "
                  "enable notifications."),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: const Text("Accept"),
                  onPressed: () {
                    Navigator.pop(context);
                    context.read<NotificationsCubit>().openSettings();
                  },
                ),
              ],
            ),
          );
        } else if (state is NotificationsError){}
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('didit'),
          leading: IconButton(
            onPressed: () => context.pushNamed('Friends'),
            icon: const Icon(Icons.people_alt_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed(
                'Profile',
                extra: const UserModel(
                  objectId: '',
                  createdAt: '',
                  username: 'James',
                  proPicUri:
                      'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                  friendState: 'ME',
                  requestId: '',
                ),
              ),
              icon: const Icon(Icons.person_rounded),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FilledButton(
          onPressed: () => showDialog(
            context: context,
            builder: (context) => const MatchDialog(),
          ),
          child: const Text('Match'),
        ),
        body: ShaderMask(
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.center,
              stops: [0, 0.25],
              colors: <Color>[Colors.black, Colors.white],
              tileMode: TileMode.mirror,
            ).createShader(bounds);
          },
          child: BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostsLoaded) {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, i) {
                    return PostView(postModel: state.posts[i]);
                  },
                );
              } else if (state is PostsEmpty) {
                return const Center(child: Text("No Posts"));
              } else if (state is PostsError) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}