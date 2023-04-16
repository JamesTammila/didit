import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/feature/search/bloc/cubit_item_filter_request.dart';
import 'package:didit/feature/friends/widget/view_picture_large.dart';
import 'package:didit/common/dialog_error.dart';

class RequestFilterItem extends StatelessWidget {
  const RequestFilterItem({super.key, required this.friendModel});

  final FriendModel friendModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<RequestFilterItemCubit>().addRecent(friendModel.user);
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
      trailing: BlocListener<RequestFilterItemCubit, RequestFilterItemState>(
        listener: (context, state) {
          if (state is RequestFilterItemError) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(error: state.error),
            );
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () =>
                  context.read<RequestFilterItemCubit>().acceptRequest(friendModel),
              child: const Text('Accept'),
            ),
            IconButton(
              onPressed: () =>
                  context.read<RequestFilterItemCubit>().rejectRequest(friendModel),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}