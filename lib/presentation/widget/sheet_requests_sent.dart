import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_requests_sent.dart';
import 'package:didit/presentation/widget/view_request_sent.dart';

class SentRequestsSheet extends StatelessWidget {
  const SentRequestsSheet({super.key});

  @override
  Widget build(context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Card(child: SizedBox(height: 5, width: 50)),
        const SizedBox(height: 20),
        const Center(child: Text('Sent Requests')),
        const SizedBox(height: 10),
        const Divider(),
        Flexible(
          child: BlocBuilder<SentRequestsCubit, SentRequestsState>(
            builder: (context, state) {
              if (state is SentRequestsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is SentRequestsLoaded) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  itemCount: state.sentRequests.length,
                  itemBuilder: (context, i) {
                    return SentRequestView(userModel: state.sentRequests[i]);
                  },
                );
              } else if (state is SentRequestsEmpty) {
                return const Center(child: Text("No Sent Requests"));
              } else if (state is SentRequestsError) {
                return Center(child: Text(state.error));
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        SizedBox(height: MediaQuery.of(context).viewPadding.bottom),
      ],
    );
  }
}