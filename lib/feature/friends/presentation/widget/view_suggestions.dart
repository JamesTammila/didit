import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/util/cubit_share.dart';
import 'package:didit/feature/friends/domain/bloc/cubit_suggestions.dart';
import 'package:didit/feature/friends/presentation/widget/view_suggestion.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.top + 5),
        ),
        SliverToBoxAdapter(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () => context.read<ShareCubit>().shareLink(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Invite your friends to didit!'),
                  trailing: Icon(Icons.share),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Contacts Using didit'),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        BlocBuilder<SuggestionsCubit, SuggestionsState>(
          builder: (context, state) {
            if (state is SuggestionsLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is SuggestionsLoaded) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.suggestions.length,
                  (context, i) {
                    return SuggestionView(userModel: state.suggestions[i]);
                  },
                ),
              );
            } else if (state is SuggestionsEmpty) {
              return const SliverFillRemaining(
                  child: Center(child: Text("No Friends")));
            } else if (state is SuggestionsError) {
              return SliverFillRemaining(
                  child: Center(child: Text(state.error)));
            } else {
              return const SliverToBoxAdapter(child: SizedBox());
            }
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.bottom),
        ),
      ],
    );
  }
}