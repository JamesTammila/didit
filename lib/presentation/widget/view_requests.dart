import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_requests.dart';
import 'package:didit/presentation/widget/view_user.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: SizedBox(height: 70)),
        SliverToBoxAdapter(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintText: 'Search or Find Friends',
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Card(
            child: InkWell(
              onTap: () => context.read<ShareCubit>().shareLink(),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Invite your friends to didit!'),
                    Icon(Icons.share),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text('Friend requests'),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 10)),
        BlocBuilder<RequestsCubit, RequestsState>(
          builder: (context, state) {
            if (state is RequestsLoading) {
              return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is RequestsLoaded) {
              return SliverList.builder(
                itemCount: state.requests.length,
                itemBuilder: (context, i) {
                  return UserView(userModel: state.requests[i]);
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
      ],
    );
  }
}