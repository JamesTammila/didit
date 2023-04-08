import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/widget/dialog_unfriend.dart';
import 'package:didit/common/dialog_error.dart';

class UserActionMenu extends StatelessWidget {
  const UserActionMenu({super.key});

  @override
  Widget build(context) {
    return BlocConsumer<UserCubit, UserState>(
      listenWhen: (previousState, state) {
        if (state is UserMenuError) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state is UserMenuError) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(error: state.error),
          );
        }
      },
      buildWhen: (previousState, state) {
        if (state is UserMenuError) {
          return false;
        } else {
          return true;
        }
      },
      builder: (BuildContext context, state) {
        if (state is UserFriend) {
          final UserCubit bloc = context.read<UserCubit>();
          return PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String choice) {
              if (choice == 'Unfriend') {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: const UnfriendDialog(),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'Unfriend',
                child: Text('Unfriend', style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        } else if (state is UserLoadingError) {
          return const Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text('Error', style: TextStyle(color: Colors.red)),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}