import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/account/bloc/cubit_memories.dart';
import 'package:didit/feature/account/widget/item_memory.dart';

class MemoriesView extends StatelessWidget {
  const MemoriesView({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<MemoriesCubit, MemoriesState>(
      builder: (BuildContext context, state) {
        if (state is MemoriesLoading) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 1),
              ),
            ),
          );
        } else if (state is MemoriesLoaded) {
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: state.memories.length,
              (context, i) {
                return MemoryItem(postModel: state.memories.values.elementAt(i));
              },
            ),
          );
        } else if (state is MemoriesEmpty) {
          return const SliverToBoxAdapter(
            child: Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: Text(
                    'No Memories Yet',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        } else if (state is MemoriesError) {
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