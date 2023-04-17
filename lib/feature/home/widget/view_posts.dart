import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/feature/home/widget/item_post.dart';

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        if (state is PostsLoading) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              child: AspectRatio(
                aspectRatio: 1,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 1),
                ),
              ),
            ),
          );
        } else if (state is PostsLoaded) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: state.posts.length,
              (context, i) {
                return BlocProvider<PagerCubit>(
                  create: (context) => PagerCubit(),
                  child: PostItem(
                    postModel: state.posts.values.elementAt(i),
                  ),
                );
              },
            ),
          );
        } else if (state is PostsEmpty) {
          return SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: const [
                    Text(
                      'No Posts',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Add more friends to see more posts!'),
                  ],
                ),
              ),
            ),
          );
        } else if (state is PostsError) {
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
    );
  }
}