import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/presentation/widget/view_match_current.dart';
import 'package:didit/presentation/widget/view_matches.dart';
import 'package:didit/presentation/widget/dialog_notifications.dart';

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
            builder: (context) => const NotificationsDialog(),
          );
        } else if (state is NotificationsError) {}
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              centerTitle: true,
              title: const Text('didit'),
              leading: IconButton(
                onPressed: () => context.pushNamed('friends'),
                icon: const Icon(Icons.people_alt_rounded),
              ),
              actions: [
                IconButton(
                  onPressed: () => context.pushNamed('profile'),
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
            const SliverToBoxAdapter(child: CurrentMatchView()),
            const SliverToBoxAdapter(child: SizedBox(height: 10)),
            const MatchesView(),
            SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).viewPadding.bottom)),
          ],
        ),
      ),
    );
  }
}