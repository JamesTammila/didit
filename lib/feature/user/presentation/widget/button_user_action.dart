import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/domain/bloc/cubit_user.dart';

class UserActionButton extends StatelessWidget {
  const UserActionButton({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<UserCubit, UserState>(
      buildWhen: (previousState, state) {
        if (state is UserRandom || state is UserPending) {
          return true;
        } else {
          return false;
        }
      },
      builder: (BuildContext context, state) {
        if (state is UserPending) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Card(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Pending'),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => context.read<UserCubit>().cancelRequest(),
                child: const Text('Cancel Request'),
              ),
            ],
          );
        } else if (state is UserWaiting) {
          return Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () => context.read<UserCubit>().acceptRequest(),
                  child: const Text('Accept'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.read<UserCubit>().rejectRequest(),
                  child: const Text('Reject'),
                ),
              ),
            ],
          );
        } else if (state is UserRandom) {
          return FilledButton(
            onPressed: () => context.read<UserCubit>().sendRequest(),
            child: const Text('Add Friend'),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}