import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/account/bloc/cubit_memories_page.dart';
import 'package:didit/feature/account/bloc/cubit_pager.dart';
import 'package:didit/feature/account/widget/item_memory.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MemoryPage extends StatelessWidget {
  const MemoryPage({super.key});

  @override
  Widget build(context) {
    final double paddingTop = MediaQuery.of(context).padding.top + kToolbarHeight;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
    final double alignmentTop = paddingTop / MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Memories'),
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
            final double alignment;
            if (state.index == 0) {
              alignment = 0;
            } else {
              alignment = alignmentTop;
            }
            debugPrint(state.index.toString());
            return ScrollablePositionedList.builder(
              initialAlignment: alignment,
              padding: EdgeInsets.only(top: paddingTop, bottom: paddingBottom),
              initialScrollIndex: state.index,
              itemCount: state.memories.length,
              itemBuilder: (context, i) {
                return BlocProvider<PagerCubit>(
                  create: (context) => PagerCubit(),
                  child: MemoryItem(
                    postModel: state.memories.values.elementAt(i),
                  ),
                );
              },
            );
          } else if (state is MemoriesPageEmpty) {
            return const Center(child: Text('No Memories Yet'));
          } else if (state is MemoriesError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}