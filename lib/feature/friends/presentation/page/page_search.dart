import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/friends/domain/bloc/cubit_search.dart';
import 'package:didit/feature/friends/presentation/widget/view_recent.dart';
import 'package:didit/feature/friends/presentation/widget/view_search.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();

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
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (s) =>
                context.read<SearchCubit>().fetchSearch(controller.text),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12),
              icon: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              hintText: 'Search or Find Friends',
              suffixIcon: IconButton(
                onPressed: () {
                  if (controller.text.isEmpty) {
                    context.pop();
                  } else {
                    controller.clear();
                    context.read<SearchCubit>().fetchSearch(controller.text);
                  }
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        ),
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
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
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
                return SearchView(userModel: state.search[i]);
              },
            );
          } else if (state is SearchSuggestions) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).padding.top + 20,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text('Recent'),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.suggestions.length,
                    (context, i) {
                      return RecentView(userModel: state.suggestions[i]);
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
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 25),
              child: const Center(child: Text('No Results')),
            );
          } else if (state is SearchError) {
            return Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 25),
              child: Center(child: Text(state.error)),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}