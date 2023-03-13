import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/feature/friends/widget/view_picture_large.dart';

class SuggestionItem extends StatelessWidget {
  const SuggestionItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed('user', extra: userModel),
      leading: LargePictureView(userModel: userModel),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userModel.username),
          const SizedBox(height: 5),
          Text(userModel.name, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}