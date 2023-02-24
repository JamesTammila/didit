import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/bloc/cubit_search.dart';
import 'package:didit/domain/model/model_friend.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

class RecentView extends StatelessWidget {
  const RecentView({super.key, required this.friendModel});

  final FriendModel friendModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed('user', extra: friendModel),
      leading: LargePictureView(uri: friendModel.user.proPicUri),
      title: Text(friendModel.user.username),
      trailing: IconButton(
        onPressed: () =>
            context.read<SearchCubit>().removeSuggestion(friendModel),
        icon: const Icon(Icons.clear),
      ),
    );
  }
}