import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/widget/dialog_unfriend.dart';

class FriendMenuSheet extends StatelessWidget {
  const FriendMenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final UserCubit bloc = context.read<UserCubit>();
    final double paddingBottom = MediaQuery.of(context).padding.bottom + 10;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.share),
                SizedBox(width: 15),
                Text('Share Profile (Coming Soon)'),
              ],
            ),
            onPressed: () => {},
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.block, color: Colors.red),
                SizedBox(width: 15),
                Text(
                  'Block User (Coming Soon)',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            onPressed: () => {},
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.report, color: Colors.red),
                SizedBox(width: 15),
                Text(
                  'Report User (Coming Soon)',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            onPressed: () => {},
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.remove_circle, color: Colors.red),
                SizedBox(width: 15),
                Text(
                  'Unfriend',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => BlocProvider.value(
                value: bloc,
                child: const UnfriendDialog(),
              ),
            ),
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}