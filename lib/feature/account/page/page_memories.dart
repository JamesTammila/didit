import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/account/bloc/cubit_memories_page.dart';
import 'package:didit/feature/account/bloc/cubit_pager.dart';
import 'package:didit/feature/account/widget/item_memory.dart';

class MemoryPage extends StatelessWidget {
  const MemoryPage({super.key});

  @override
  Widget build(context) {
    final double topPadding = MediaQuery.of(context).padding.top + kToolbarHeight;
    final double bottomPadding = MediaQuery.of(context).padding.bottom;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Your Memories'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.transparent],
            ),
          ),
        ),
      ),
      body: BlocBuilder<MemoriesPageCubit, MemoriesPageState>(
        builder: (context, state) {
          if (state is MemoriesPageLoading) {
            return const Center(
              child: CircularProgressIndicator(strokeWidth: 1),
            );
          } else if (state is MemoriesPageLoaded) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: state.index),
              itemCount: state.memories.length,
              itemBuilder: (context, i) {
                return BlocProvider<PagerCubit>(
                  create: (context) => PagerCubit(),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: topPadding,
                      bottom: bottomPadding,
                    ),
                    child: MemoryItem(
                      postModel: state.memories.values.elementAt(i),
                    ),
                  ),
                );
              },
            );
          } else if (state is MemoriesPageEmpty) {
            return const Center(child: Text('No Memories Yet'));
          } else if (state is MemoriesPageError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}