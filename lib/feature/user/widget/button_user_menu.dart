import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/widget/sheet_user_menu.dart';
import 'package:didit/common/dialog_error.dart';

class UserMenuButton extends StatelessWidget {
  const UserMenuButton({super.key});

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
          return IconButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: const UserMenuSheet(),
              ),
            ),
            icon: const Icon(Icons.more_vert),
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