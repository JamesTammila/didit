import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/friends/bloc/cubit_search.dart';
import 'package:didit/feature/friends/widget/item_recent.dart';
import 'package:didit/feature/friends/widget/item_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            controller: controller,
            autofocus: true,
            onChanged: (s) =>
                context.read<SearchCubit>().fetchSearch(controller.text),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12),
              icon: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              hintText: 'Add or Find Friends',
              suffixIcon: IconButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    context.pop();
                  } else {
                    controller.clear();
                    context.read<SearchCubit>().fetchSearch('');
                  }
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
          ),
        ],
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
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return Padding(
              padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 25,
              left: 20,
            ),
              child: Row(
                children: const [
                  CircularProgressIndicator(strokeWidth: 1),
                  SizedBox(width: 20),
                  Text('Searching...'),
                ],
              ),
            );
          } else if (state is SearchLoaded) {
            return ListView.builder(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: MediaQuery.of(context).padding.bottom,
              ),
              itemCount: state.search.length,
              itemBuilder: (context, i) {
                return SearchItem(userModel: state.search.values.elementAt(i));
              },
            );
          } else if (state is SearchRecent) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 20,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text('Recent'),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.recent.length,
                    (context, i) {
                      return RecentItem(
                        userModel: state.recent.values.elementAt(i),
                      );
                    },
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.bottom,
                  ),
                ),
              ],
            );
          } else if (state is SearchEmpty) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 25,
                left: 15,
              ),
              child: const Text('No Results'),
            );
          } else if (state is SearchError) {
            return Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 25,
                left: 15,
              ),
              child: Text(state.error),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}