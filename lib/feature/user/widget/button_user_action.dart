import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/common/dialog_error.dart';

class UserActionButton extends StatefulWidget {
  const UserActionButton({super.key});

  @override
  UserActionButtonState createState() => UserActionButtonState();
}

class UserActionButtonState extends State<UserActionButton> with TickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 250),
    vsync: this,
  )..forward(from: 0);
  late final Animation<double> animation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocConsumer<UserCubit, UserState>(
      listenWhen: (previousState, state) {
        if (state is UserButtonError) {
          return true;
        } else {
          return false;
        }
      },
      listener: (context, state) {
        if (state is UserButtonError) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(error: state.error),
          );
        }
      },
      buildWhen: (previousState, state) {
        if (state is UserButtonError) {
          return false;
        } else {
          return true;
        }
      },
      builder: (BuildContext context, state) {
        if (state is UserPending) {
          return FadeTransition(
            opacity: animation,
            child: Column(
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
            ),
          );
        } else if (state is UserWaiting) {
          return FadeTransition(
            opacity: animation,
            child: Row(
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
            ),
          );
        } else if (state is UserRandom) {
          return FadeTransition(
            opacity: animation,
            child: FilledButton(
              onPressed: () => context.read<UserCubit>().sendRequest(),
              child: const Text('Add Friend'),
            ),
          );
        } else if (state is UserLoadingError) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(state.error),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}