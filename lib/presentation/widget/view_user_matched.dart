import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_medium.dart';

class MatchedUserView extends StatelessWidget {
  const MatchedUserView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('user', extra: userModel),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                MediumPictureView(uri: userModel.proPicUri),
                const SizedBox(width: 10),
                Text(userModel.username),
              ],
            ),
            const Icon(Icons.access_time_filled, color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}