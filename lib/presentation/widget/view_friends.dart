import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_friends.dart';
import 'package:didit/presentation/widget/view_friend.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

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
            child: Text('My Friends'),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        BlocBuilder<FriendsCubit, FriendsState>(
          builder: (context, state) {
            if (state is FriendsLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is FriendsLoaded) {
              return SliverList.builder(
                itemCount: state.friends.length,
                itemBuilder: (context, i) {
                  return FriendView(friendModel: state.friends[i]);
                },
              );
            } else if (state is FriendsEmpty) {
              return const SliverFillRemaining(
                  child: Center(child: Text("No Friends")));
            } else if (state is FriendsError) {
              return SliverFillRemaining(
                  child: Center(child: Text(state.error)));
            } else {
              return const SizedBox();
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