import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/bloc/cubit_suggestions.dart';
import 'package:didit/feature/friends/widget/view_share.dart';
import 'package:didit/feature/friends/widget/item_suggestion.dart';

class SuggestionsView extends StatelessWidget {
  const SuggestionsView({super.key});

  @override
  Widget build(context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('SUGGESTIONS'),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.top)),
        const SliverToBoxAdapter(child: ShareView()),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Contacts Using Jumbl'),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        const SliverToBoxAdapter(
          child: Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Center(
                child: Text('Feature is coming soon!'),
              ),
            ),
          ),
        ),
        /*BlocBuilder<SuggestionsCubit, SuggestionsState>(
          builder: (context, state) {
            if (state is SuggestionsLoading) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ),
              );
            } else if (state is SuggestionsLoaded) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.suggestions.length,
                  (context, i) {
                    return SuggestionItem(
                      userModel: state.suggestions.values.elementAt(i),
                    );
                  },
                ),
              );
            } else if (state is SuggestionsEmpty) {
              return SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: const [
                        Text(
                          'No Contacts',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('You have no contacts using Jumble at the moment, '
                            'they will show up here once they download the '
                            'app.'),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is SuggestionsError) {
              return SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        state.error,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return const SliverToBoxAdapter(child: SizedBox());
            }
          },
        ),*/
        SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom)),
      ],
    );
  }
}