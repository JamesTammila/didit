import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_notifications.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/feature/home/widget/view_post.dart';
import 'package:didit/feature/home/widget/dialog_permission_notifications.dart';
import 'package:didit/common/cubit_appsettings.dart';

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
            builder: (context) => BlocProvider<AppSettingsCubit>(
              create: (context) => AppSettingsCubit(),
              child: const NotificationsDialog(),
            ),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Jumbl'),
          actions: [
            IconButton(
              onPressed: () => context.pushNamed('match'),
              icon: const Icon(Icons.add_box_rounded),
            ),
            IconButton(
              onPressed: () => context.pushNamed('friends'),
              icon: const Icon(Icons.people_alt_rounded),
            ),
            IconButton(
              onPressed: () => context.pushNamed('account'),
              icon: const Icon(Icons.person_rounded),
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
        body: RefreshIndicator(
          displacement: MediaQuery.of(context).padding.top + kToolbarHeight,
          onRefresh: () => context.read<PostsCubit>().refreshPosts(),
          child: BlocBuilder<PostsCubit, PostsState>(
            builder: (context, state) {
              if (state is PostsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is PostsLoaded) {
                return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, i) {
                    return BlocProvider<PagerCubit>(
                      create: (context) => PagerCubit(),
                      child: PostView(
                        postModel: state.posts.values.elementAt(i),
                      ),
                    );
                  },
                );
              } else if (state is PostsEmpty) {
                return const Center(child: Text('No Posts'));
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