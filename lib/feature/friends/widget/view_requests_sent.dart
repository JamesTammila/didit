import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/bloc/cubit_requests_sent.dart';
import 'package:didit/feature/friends/widget/item_request_sent.dart';

class SentRequestsView extends StatelessWidget {
  const SentRequestsView({super.key});

  @override
  Widget build(context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Card(color: Colors.white, child: SizedBox(height: 5, width: 50)),
        const SizedBox(height: 20),
        const Center(child: Text('Sent Requests')),
        const SizedBox(height: 20),
        const Divider(),
        BlocBuilder<SentRequestsCubit, SentRequestsState>(
          builder: (context, state) {
            if (state is SentRequestsLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(strokeWidth: 1),
              );
            } else if (state is SentRequestsLoaded) {
              return Flexible(
                child: ListView.builder(
                  itemCount: state.sentRequests.length,
                  itemBuilder: (context, i) {
                    return SentRequestItem(
                      userModel: state.sentRequests.values.elementAt(i),
                    );
                  },
                ),
              );
            } else if (state is SentRequestsEmpty) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: const [
                      Text(
                        'No Sent Requests',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('You have no sent friend requests at the '
                          'moment.'),
                    ],
                  ),
                ),
              );
            } else if (state is SentRequestsError) {
              return Card(
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
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}