import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/domain/bloc/cubit_match.dart';
import 'package:didit/presentation/widget/view_match.dart';
import 'package:didit/presentation/widget/dialog_permission_notifications.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    FlutterNativeSplash.remove();
    final bloc = context.read<NotificationsCubit>();
    return BlocListener<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationsDenied) {
          showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
              value: bloc,
              child: const NotificationsDialog(),
            ),
          );
        } else if (state is NotificationsError) {}
      },
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
          body: RefreshIndicator(
            displacement:
                MediaQuery.of(context).viewPadding.top + kToolbarHeight + 25,
            onRefresh: () => context.read<MatchesCubit>().refreshMatches(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  floating: true,
                  title: const Text('didit'),
                  actions: [
                    IconButton(
                      onPressed: () => context.pushNamed('currentMatch'),
                      icon: const Icon(Icons.add_circle),
                    ),
                    IconButton(
                      onPressed: () => context.pushNamed('friends'),
                      icon: const Icon(Icons.people_alt_rounded),
                    ),
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
                BlocBuilder<MatchesCubit, MatchesState>(
                  builder: (context, state) {
                    if (state is MatchesLoading) {
                      return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is MatchesLoaded) {
                      return SliverList.builder(
                        itemCount: state.matches.length,
                        itemBuilder: (context, i) {
                          return BlocProvider<MatchCubit>(
                            create: (context) => MatchCubit(),
                            child: MatchView(matchModel: state.matches[i]),
                          );
                        },
                      );
                    } else if (state is MatchesEmpty) {
                      return const SliverFillRemaining(
                          child: Center(child: Text("No Posts")));
                    } else if (state is MatchesError) {
                      return SliverFillRemaining(
                          child: Center(child: Text(state.error)));
                    } else {
                      return const SliverFillRemaining(child: SizedBox());
                    }
                  },
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}