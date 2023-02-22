import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_requests.dart';
import 'package:didit/domain/bloc/cubit_requests_sent.dart';
import 'package:didit/presentation/widget/view_request.dart';
import 'package:didit/presentation/widget/sheet_requests_sent.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.top + 5),
        ),
        SliverToBoxAdapter(
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () => context.read<ShareCubit>().shareLink(),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: ListTile(
                  title: Text('Invite your friends to didit!'),
                  trailing: Icon(Icons.share),
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
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
                      create: (context) => SentRequestsCubit(),
                      child: const SentRequestsSheet(),
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
        const SliverToBoxAdapter(child: SizedBox(height: 20)),
        BlocBuilder<RequestsCubit, RequestsState>(
          builder: (context, state) {
            if (state is RequestsLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is RequestsLoaded) {
              return SliverList.builder(
                itemCount: state.requests.length,
                itemBuilder: (context, i) {
                  return RequestView(userModel: state.requests[i]);
                },
              );
            } else if (state is RequestsEmpty) {
              return const SliverFillRemaining(
                  child: Center(child: Text("No Friends")));
            } else if (state is RequestsError) {
              return SliverFillRemaining(
                  child: Center(child: Text(state.error)));
            } else {
              return const SizedBox();
            }
          },
        ),
        SliverToBoxAdapter(
          child: SizedBox(height: MediaQuery.of(context).padding.bottom),
        ),
      ],
    );
  }
}