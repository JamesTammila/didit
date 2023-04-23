import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/widget/sheet_menu_friend.dart';
import 'package:didit/feature/user/widget/sheet_menu_me.dart';
import 'package:didit/feature/user/widget/sheet_menu_random.dart';
import 'package:didit/common/dialog_error.dart';

class UserMenuButton extends StatelessWidget {
  const UserMenuButton({super.key});

  @override
  Widget build(context) {
    final UserCubit bloc = context.read<UserCubit>();
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
          return IconButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: const FriendMenuSheet(),
              ),
            ),
            icon: const Icon(Icons.more_vert),
          );
        } else if (state is UserMe) {
          return IconButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: const MeMenuSheet(),
              ),
            ),
            icon: const Icon(Icons.more_vert),
          );
        } else if (state is UserLoadingError) {
          return IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => ErrorDialog(error: state.error),
            ),
            icon: const Icon(Icons.more_vert),
          );
        } else {
          return IconButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: const RandomMenuSheet(),
              ),
            ),
            icon: const Icon(Icons.more_vert),
          );
        }
      },
    );
  }
}