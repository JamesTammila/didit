import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/domain/bloc/cubit_user.dart';

class UserActionMenu extends StatelessWidget {
  const UserActionMenu({super.key});

  @override
  Widget build(context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, state) {
        if (state is UserFriend) {
          return PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () => context.read<UserCubit>().unfriend(),
                child: const Text('Unfriend'),
              ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}