import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/bloc/cubit_friends.dart';
import 'package:didit/feature/friends/widget/view_share.dart';
import 'package:didit/feature/friends/widget/item_friend.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(context) {
    return RefreshIndicator(
      edgeOffset: MediaQuery.of(context).padding.top + 150,
      onRefresh: () => context.read<FriendsCubit>().refresh(),
      child: CustomScrollView(
        key: const PageStorageKey<String>('FRIENDS'),
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.top)),
          const SliverToBoxAdapter(child: ShareView()),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text('My Friends'),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          BlocBuilder<FriendsCubit, FriendsState>(
            builder: (context, state) {
              if (state is FriendsLoading) {
                return const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: CircularProgressIndicator(strokeWidth: 1),
                    ),
                  ),
                );
              } else if (state is FriendsLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.friends.length,
                    (context, i) {
                      return FriendItem(
                        userModel: state.friends.values.elementAt(i),
                      );
                    },
                  ),
                );
              } else if (state is FriendsEmpty) {
                return SliverToBoxAdapter(
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        children: const [
                          Text(
                            'No Friends',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Text('You have no friends at the moment, add some so '
                              'you can start seeing and sharing posts.'),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (state is FriendsError) {
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
          ),
          SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom)),
        ],
      ),
    );
  }
}