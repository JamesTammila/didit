import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

class SentRequestView extends StatelessWidget {
  const SentRequestView({super.key, required this.userModel});

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
                LargePictureView(uri: userModel.proPicUri),
                const SizedBox(width: 10),
                Text(userModel.username),
              ],
            ),
            IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.close),
            ),
          ],
        ),
      ),
    );
  }
}