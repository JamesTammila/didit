import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/friends/domain/bloc/cubit_search.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/feature/friends/presentation/widget/view_picture_large.dart';

class RecentView extends StatelessWidget {
  const RecentView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed('user', extra: userModel),
      leading: LargePictureView(uri: userModel.proPicUri),
      title: Text(userModel.username),
      trailing: IconButton(
        onPressed: () =>
            context.read<SearchCubit>().removeSuggestion(userModel),
        icon: const Icon(Icons.clear),
      ),
    );
  }
}