import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/feature/friends/bloc/cubit_requests.dart';
import 'package:didit/feature/friends/bloc/cubit_requests_sent.dart';
import 'package:didit/feature/friends/widget/view_share.dart';
import 'package:didit/feature/friends/widget/item_request.dart';
import 'package:didit/feature/friends/widget/view_requests_sent.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(context) {
    return CustomScrollView(
      key: const PageStorageKey<String>('REQUESTS'),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.top)),
        const SliverToBoxAdapter(child: ShareView()),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Friend Requests'),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (context) => BlocProvider<SentRequestsCubit>(
                      create: (context) => SentRequestsCubit(
                        context.read<UserRepository>(),
                      )..init(),
                      child: const SentRequestsView(),
                    ),
                  ),
                  child: const Text(
                    'Sent Requests',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        BlocBuilder<RequestsCubit, RequestsState>(
          builder: (context, state) {
            if (state is RequestsLoading) {
              return const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: CircularProgressIndicator(strokeWidth: 1),
                  ),
                ),
              );
            } else if (state is RequestsLoaded) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: state.requests.length,
                  (context, i) {
                    return RequestItem(
                      userModel: state.requests.values.elementAt(i),
                    );
                  },
                ),
              );
            } else if (state is RequestsEmpty) {
              return SliverToBoxAdapter(
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      children: const [
                        Text(
                          'No Requests',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('You have no pending friend requests at the '
                            'moment.'),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is RequestsError) {
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
        ),
        SliverToBoxAdapter(child: SizedBox(height: MediaQuery.of(context).padding.bottom)),
      ],
    );
  }
}