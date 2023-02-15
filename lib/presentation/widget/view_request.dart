import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

class RequestView extends StatelessWidget {
  const RequestView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 25,
      onTap: () => context.pushNamed('user', extra: userModel),
      leading: LargePictureView(uri: userModel.proPicUri),
      title: Text(userModel.username),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => {},
            child: const Text('ACCEPT'),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}