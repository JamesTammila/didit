import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_notifications.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/feature/home/widget/item_post.dart';
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
            BlocBuilder<NotificationsCubit, NotificationsState>(
              buildWhen: (previousState, state) {
                if (state is NotificationsMatch ||
                    state is NotificationsResetMatch) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is NotificationsMatch) {
                  return IconButton(
                    onPressed: () {
                      context.pushNamed('match');
                      context.read<NotificationsCubit>().resetMatch();
                    },
                    icon: const Badge(
                      child: Icon(Icons.add_circle),
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () => context.pushNamed('match'),
                    icon: const Icon(Icons.add_circle),
                  );
                }
              },
            ),
            BlocBuilder<NotificationsCubit, NotificationsState>(
              buildWhen: (previousState, state) {
                if (state is NotificationsRequest ||
                    state is NotificationsAccept ||
                    state is NotificationsResetFriends) {
                  return true;
                } else {
                  return false;
                }
              },
              builder: (context, state) {
                if (state is NotificationsRequest ||
                    state is NotificationsRequest) {
                  return IconButton(
                    onPressed: () {
                      context.pushNamed('friends');
                      context.read<NotificationsCubit>().resetFriends();
                    },
                    icon: const Badge(
                      child: Icon(Icons.people_alt_rounded),
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () => context.pushNamed('friends'),
                    icon: const Icon(Icons.people_alt_rounded),
                  );
                }
              },
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
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + kToolbarHeight,
              ),
              sliver: CupertinoSliverRefreshControl(
                refreshTriggerPullDistance: 150,
                onRefresh: () => context.read<PostsCubit>().refreshPosts(),
                builder: (BuildContext context,
                    RefreshIndicatorMode refreshState,
                    double pulledExtent,
                    double refreshTriggerPullDistance,
                    double? pulledExtentPercentage) {
                  if (refreshState == RefreshIndicatorMode.refresh ||
                      refreshState == RefreshIndicatorMode.armed) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            BlocBuilder<PostsCubit, PostsState>(
              builder: (context, state) {
                if (state is PostsLoading) {
                  return const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 1),
                      ),
                    ),
                  );
                } else if (state is PostsLoaded) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.posts.length,
                      (context, i) {
                        return BlocProvider<PagerCubit>(
                          create: (context) => PagerCubit(),
                          child: PostItem(
                            postModel: state.posts.values.elementAt(i),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is PostsEmpty) {
                  return SliverToBoxAdapter(
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          children: const [
                            Text(
                              'No Posts',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text('You need at least 3 friends to start '
                                'matching, add some so you can start viewing '
                                'and sharing posts.'),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (state is PostsError) {
                  return SliverToBoxAdapter(
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Center(
                          child: Text(
                            state.error,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(child: SizedBox());
                }
              },
            ),
            SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom)),
          ],
        ),
      ),
    );
  }
}