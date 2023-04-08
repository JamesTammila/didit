import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/feature/friends/bloc/cubit_friends.dart';
import 'package:didit/feature/friends/widget/view_picture_large.dart';
import 'package:didit/feature/friends/widget/dialog_unfriend.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({super.key, required this.friendModel});

  final FriendModel friendModel;

  @override
  Widget build(BuildContext context) {
    final FriendsCubit bloc = context.read<FriendsCubit>();
    return ListTile(
      onTap: () => context.pushNamed('user', extra: friendModel.user),
      leading: LargePictureView(userModel: friendModel.user),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(friendModel.user.username),
          const SizedBox(height: 5),
          Text(
            friendModel.user.name,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => BlocProvider.value(
            value: bloc,
            child: UnfriendDialog(friendModel: friendModel),
          ),
        ),
        icon: const Icon(Icons.close),
      ),
    );
  }
}