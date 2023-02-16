import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/bloc/cubit_search.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

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
            return Center(
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
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20),
              itemCount: state.users.length,
              itemBuilder: (context, i) {
                return ListTile(
                  minVerticalPadding: 25,
                  onTap: () => context.pushNamed('user', extra: state.users[i]),
                  leading: LargePictureView(uri: state.users[i].proPicUri),
                  title: Text(state.users[i].username),
                );
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
                SliverList.builder(
                  itemCount: state.users.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      minVerticalPadding: 25,
                      onTap: () =>
                          context.pushNamed('user', extra: state.users[i]),
                      leading: LargePictureView(uri: state.users[i].proPicUri),
                      title: Text(state.users[i].username),
                      trailing: IconButton(
                        onPressed: () => {},
                        icon: const Icon(Icons.clear),
                      ),
                    );
                  },
                ),
              ],
            );
          } else if (state is SearchEmpty) {
            return const Center(child: Text('No Results'));
          } else if (state is SearchError) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}