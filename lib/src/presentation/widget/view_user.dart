import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/src/domain/model/model_user.dart';
import 'package:didit/src/presentation/widget/view_picture.dart';

class UserView extends StatelessWidget {
  const UserView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('Profile', extra: userModel),
      child: Row(
        children: [
          PictureView(uri: userModel.proPicUri),
          const SizedBox(width: 5),
          Text(userModel.username),
        ],
      ),
    );
  }
}