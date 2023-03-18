import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/feature/home/widget/view_match_finished.dart';
import 'package:didit/feature/home/widget/view_match_unfinished.dart';
import 'package:didit/feature/home/widget/dialog_permission_post.dart';
import 'package:didit/common/cubit_appsettings.dart';
import 'package:didit/common/dialog_error.dart';

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Today's Match"),
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
      body: BlocConsumer<MatchCubit, MatchState>(
        listenWhen: (previousState, state) {
          if (state is MatchPermission ||
              state is MatchFailure ||
              state is MatchUnfinishedUploading ||
              state is MatchUnfinishedUploaded ||
              state is MatchFinishedDeleting ||
              state is MatchFinishedDeleted) {
            return true;
          } else {
            return false;
          }
        },
        listener: (BuildContext context, state) {
          if (state is MatchPermission) {
            showDialog(
              context: context,
              builder: (context) => BlocProvider<AppSettingsCubit>(
                create: (context) => AppSettingsCubit(),
                child: const CameraPostDialog(),
              ),
            );
          }
          if (state is MatchFailure) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(error: state.error),
            );
          }
          if (state is MatchUnfinishedUploading) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Uploading...')
                    ],
                  ),
                );
              },
            );
          }
          if (state is MatchUnfinishedUploaded) {
            context.pop();
            context.pop();
          }
          if (state is MatchFinishedDeleting) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.only(
                    top: 20,
                    bottom: 10,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Deleting...')
                    ],
                  ),
                );
              },
            );
          }
          if (state is MatchFinishedDeleted) {
            context.pop();
            context.pop();
          }
        },
        buildWhen: (previousState, state) {
          if (state is MatchLoading ||
              state is MatchFinished ||
              state is MatchUnfinished ||
              state is MatchEmpty ||
              state is MatchError) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 1));
          } else if (state is MatchUnfinished) {
            return UnfinishedMatchView(matchModel: state.match);
          } else if (state is MatchFinished) {
            return BlocProvider<PagerCubit>(
              create: (context) => PagerCubit(),
              child: FinishedMatchView(matchModel: state.match),
            );
          } else if (state is MatchEmpty) {
            return const Center(child: Text('No Match'));
          } else if (state is MatchError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}