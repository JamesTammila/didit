import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/presentation/widget/view_match.dart';

class MatchesView extends StatelessWidget {
  const MatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MatchesCubit, MatchesState>(
      builder: (context, state) {
        if (state is MatchesLoading) {
          return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
        } else if (state is MatchesLoaded) {
          return SliverList.builder(
            itemCount: state.matches.length,
            itemBuilder: (context, i) {
              return MatchView(matchModel: state.matches[i]);
            },
          );
        } else if (state is MatchesEmpty) {
          return const SliverFillRemaining(child: Center(child: Text("No Posts")));
        } else if (state is MatchesError) {
          return SliverFillRemaining(child: Center(child: Text(state.error)));
        } else {
          return const SliverFillRemaining(child: SizedBox());
        }
      },
    );
  }
}