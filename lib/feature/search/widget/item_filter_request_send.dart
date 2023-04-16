import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_friend.dart';
import 'package:didit/feature/search/bloc/cubit_item_filter_request_sent.dart';
import 'package:didit/feature/friends/widget/view_picture_large.dart';
import 'package:didit/common/dialog_error.dart';

class SentRequestFilterItem extends StatelessWidget {
  const SentRequestFilterItem({super.key, required this.friendModel});

  final FriendModel friendModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<SentRequestFilterItemCubit>().addRecent(friendModel.user);
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
      trailing: BlocListener<SentRequestFilterItemCubit, SentRequestFilterItemState>(
        listener: (context, state) {
          if (state is SentRequestFilterItemError) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(error: state.error),
            );
          }
        },
        child: IconButton(
          onPressed: () =>
              context.read<SentRequestFilterItemCubit>().cancelRequest(friendModel),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}