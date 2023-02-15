import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MatchedUserView extends StatelessWidget {
  const MatchedUserView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 10,
      onTap: () => context.pushNamed('user', extra: userModel),
      leading: MediumPictureView(uri: userModel.proPicUri),
      title: Text(userModel.username),
      trailing: const Icon(Icons.access_time_filled, color: Colors.yellow),
    );
  }
}