import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/feature/friends/presentation/widget/view_picture_large.dart';

class MatchedUserView extends StatelessWidget {
  const MatchedUserView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => context.pushNamed('user', extra: userModel),
      leading: LargePictureView(uri: userModel.proPicUri),
      title: Text(userModel.username),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text('Posting'),
          SizedBox(width: 10),
          Icon(Icons.timelapse),
        ],
      ),
    );
  }
}