import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_suggestions.dart';
import 'package:didit/presentation/widget/view_user.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 70)),
        SliverToBoxAdapter(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search or Find Friends',
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Invite your friends!'),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () => context.read<ShareCubit>().shareLink(),
                    icon: const Icon(Icons.share),
                  ),
                ],
              ),
            ),
          ),
        ),
        BlocBuilder<SuggestionsCubit, SuggestionsState>(
          builder: (context, state) {
            if (state is SuggestionsLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is SuggestionsLoaded) {
              return SliverList.builder(
                itemCount: state.suggestions.length,
                itemBuilder: (context, i) {
                  return UserView(userModel: state.suggestions[i]);
                },
              );
            } else if (state is SuggestionsEmpty) {
              return const SliverFillRemaining(
                  child: Center(child: Text("No Friends")));
            } else if (state is SuggestionsError) {
              return SliverFillRemaining(
                  child: Center(child: Text(state.error)));
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}