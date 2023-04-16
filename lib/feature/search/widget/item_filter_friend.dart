import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/feature/search/bloc/cubit_item_filter_friend.dart';
import 'package:didit/feature/friends/widget/view_picture_large.dart';
import 'package:didit/feature/search/widget/dialog_unfriend_filter.dart';

class FriendFilterItem extends StatelessWidget {
  const FriendFilterItem({super.key, required this.friendModel});

  final FriendModel friendModel;

  @override
  Widget build(BuildContext context) {
    final FriendFilterItemCubit bloc = context.read<FriendFilterItemCubit>();
    return ListTile(
      onTap: () {
        context.read<FriendFilterItemCubit>().addRecent(friendModel.user);
        context.pushNamed('user', extra: friendModel.user);
      },
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
            child: UnfriendFilterDialog(friendModel: friendModel),
          ),
        ),
        icon: const Icon(Icons.close),
      ),
    );
  }
}