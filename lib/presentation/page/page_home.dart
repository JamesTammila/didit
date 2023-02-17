import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/domain/bloc/cubit_match_current.dart';
import 'package:didit/presentation/widget/view_matches.dart';
import 'package:didit/presentation/widget/sheet_match_current.dart';
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
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterFloat,
          floatingActionButton: ElevatedButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (context) => BlocProvider<CurrentMatchCubit>(
                create: (context) => CurrentMatchCubit(),
                child: const CurrentMatchSheet(),
              ),
            ),
            child: const Text('Match'),
          ),
          body: RefreshIndicator(
            displacement:
                MediaQuery.of(context).viewPadding.top + kToolbarHeight + 25,
            onRefresh: () => context.read<MatchesCubit>().refreshMatches(),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () => context.pushNamed('friends'),
                    icon: const Icon(Icons.people_alt_rounded),
                  ),
                  title: const Text('didit'),
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
                const MatchesView(),
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