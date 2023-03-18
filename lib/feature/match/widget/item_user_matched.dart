import 'package:flutter/material.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/feature/match/widget/view_picture_huge.dart';

class MatchedUserItem extends StatelessWidget {
  const MatchedUserItem({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        HugePictureView(userModel: userModel),
        Text(userModel.username),
      ],
    );
  }
}