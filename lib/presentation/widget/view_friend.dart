import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

class FriendView extends StatelessWidget {
  const FriendView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('user', extra: userModel),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            LargePictureView(uri: userModel.proPicUri),
            const SizedBox(width: 10),
            Text(userModel.username),
          ],
        ),
      ),
    );
  }
}