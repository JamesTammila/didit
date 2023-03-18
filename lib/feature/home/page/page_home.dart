import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_notifications.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/widget/dialog_permission_notifications.dart';
import 'package:didit/feature/home/widget/view_posts.dart';
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text('Jumbl'),
          leading: BlocBuilder<NotificationsCubit, NotificationsState>(
            buildWhen: (previousState, state) {
              if (state is NotificationsDenied ||
                  state is NotificationsMatch) {
                return false;
              } else {
                return true;
              }
            },
            builder: (context, state) {
              if (state is NotificationsRequest ||
                  state is NotificationsAccept) {
                return IconButton(
                  onPressed: () {
                    context.pushNamed('friends');
                    context.read<NotificationsCubit>().reset();
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
          actions: [
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
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 50,
                  right: 50,
                  top: 30,
                  bottom: 30,
                ),
                child: OutlinedButton(
                  onPressed: () => context.pushNamed('match'),
                  child: const Text("Today's Match"),
                ),
              ),
            ),
            const PostsView(),
            SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom)),
          ],
        ),
      ),
    );
  }
}