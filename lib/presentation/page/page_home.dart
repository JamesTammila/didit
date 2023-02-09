import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/presentation/widget/view_match_current.dart';
import 'package:didit/presentation/widget/view_match.dart';
import 'package:didit/presentation/widget/dialog_notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    final height = MediaQuery.of(context).viewPadding.top + 60;
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
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
          child: BlocBuilder<MatchesCubit, MatchesState>(
            builder: (context, state) {
              if (state is MatchesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MatchesLoaded) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: SizedBox(height: height)),
                    const SliverToBoxAdapter(child: CurrentMatchView()),
                    const SliverToBoxAdapter(child: SizedBox(height: 10)),
                    SliverList.builder(
                      itemCount: state.matches.length,
                      itemBuilder: (context, i) {
                        return MatchView(matchModel: state.matches[i]);
                      },
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 50)),
                    const SliverToBoxAdapter(child: Center(child: Text('The End'))),
                    const SliverToBoxAdapter(child: SizedBox(height: 100)),
                  ],
                );
              } else if (state is MatchesEmpty) {
                return const Center(child: Text("No Posts"));
              } else if (state is MatchesError) {
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