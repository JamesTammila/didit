import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/search/bloc/cubit_filter_friends.dart';
import 'package:didit/feature/search/bloc/cubit_filter_requests.dart';
import 'package:didit/feature/search/bloc/cubit_filter_requests_sent.dart';
import 'package:didit/feature/search/bloc/cubit_search.dart';
import 'package:didit/feature/friends/widget/item_friend.dart';
import 'package:didit/feature/friends/widget/item_request.dart';
import 'package:didit/feature/friends/widget/item_request_sent.dart';
import 'package:didit/feature/search/widget/item_recent.dart';
import 'package:didit/feature/search/widget/item_search.dart';

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
    final double paddingTop = MediaQuery.of(context).padding.top + kToolbarHeight + 10;
    final double paddingBottom = MediaQuery.of(context).padding.bottom + 10;
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
            onChanged: (s) {
              context.read<FriendsFilterCubit>().filterFriends(controller.text);
              context.read<RequestsFilterCubit>().filterRequests(controller.text);
              context.read<SentRequestsFilterCubit>().filterSentRequests(controller.text);
              context.read<SearchCubit>().fetchSearch(controller.text);
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 12),
              icon: const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              hintText: 'Add or Find Friends',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoading) {
                        return const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(strokeWidth: 1),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  IconButton(
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
                ],
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: paddingTop)),
          /*BlocBuilder<FriendsFilterCubit, FriendsFilterState>(
            builder: (context, state) {
              if (state is FriendsFilterLoaded) {
                return const SliverToBoxAdapter(child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('My Friends'),
                ));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<FriendsFilterCubit, FriendsFilterState>(
            builder: (context, state) {
              if (state is FriendsFilterLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.friends.length,
                    (context, i) {
                      return FriendItem(
                        friendModel: state.friends.values.elementAt(i),
                      );
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<RequestsFilterCubit, RequestsFilterState>(
            builder: (context, state) {
              if (state is RequestsFilterLoaded) {
                return const SliverToBoxAdapter(child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Requests'),
                ));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<RequestsFilterCubit, RequestsFilterState>(
            builder: (context, state) {
              if (state is RequestsFilterLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.requests.length,
                    (context, i) {
                      return RequestItem(
                        friendModel: state.requests.values.elementAt(i),
                      );
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<SentRequestsFilterCubit, SentRequestsFilterState>(
            builder: (context, state) {
              if (state is SentRequestsFilterLoaded) {
                return const SliverToBoxAdapter(child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Sent Requests'),
                ));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<SentRequestsFilterCubit, SentRequestsFilterState>(
            builder: (context, state) {
              if (state is SentRequestsFilterLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.sentRequests.length,
                    (context, i) {
                      return SentRequestItem(
                        friendModel: state.sentRequests.values.elementAt(i),
                      );
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),*/
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchEmpty) {
                return const SliverToBoxAdapter(child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('No Results'),
                ));
              } else if (state is SearchError) {
                return SliverToBoxAdapter(child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(state.error),
                ));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchRecent) {
                return const SliverToBoxAdapter(child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('Recent'),
                ));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchRecent) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.recent.length,
                        (context, i) {
                      return RecentItem(
                        userModel: state.recent.values.elementAt(i),
                      );
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                return const SliverToBoxAdapter(child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text('More Results'),
                ));
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.search.length,
                    (context, i) {
                      return SearchItem(
                        userModel: state.search.values.elementAt(i),
                      );
                    },
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          SliverToBoxAdapter(child: SizedBox(height: paddingBottom)),
        ],
      ),
    );
  }
}