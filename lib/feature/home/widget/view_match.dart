import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/widget/dialog_permission_post.dart';
import 'package:didit/feature/home/widget/view_match_finished.dart';
import 'package:didit/common/cubit_appsettings.dart';
import 'package:didit/common/dialog_error.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key});

  @override
  Widget build(context) {
    return BlocConsumer<MatchCubit, MatchState>(
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
      },
      buildWhen: (previousState, state) {
        if (state is MatchPermission ||
            state is MatchFailure ||
            state is MatchPictureEmpty ||
            state is MatchPicturePreview) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is MatchLoading) {
          return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator(strokeWidth: 1)));
        } else if (state is MatchLoaded) {
          return FinishedMatchView(matchModel: state.match);
        } else if (state is MatchError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        } else {
          return const SliverToBoxAdapter(child: SizedBox());
        }
      },
    );
  }
}