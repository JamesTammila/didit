import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_friends.dart';
import 'package:didit/presentation/widget/view_user.dart';

class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

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
            child: InkWell(
              onTap: () => context.read<ShareCubit>().shareLink(),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Invite your friends to didit!'),
                    Icon(Icons.share),
                  ],
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<FriendsCubit, FriendsState>(
          builder: (context, state) {
            if (state is FriendsLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is FriendsLoaded) {
              return SliverList.builder(
                itemCount: state.friends.length,
                itemBuilder: (context, i) {
                  return UserView(userModel: state.friends[i]);
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
      ],
    );
  }
}