import 'package:didit/domain/bloc/cubit_user.dart';
import 'package:didit/presentation/page/page_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/bloc/cubit_requests_sent.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

class SentRequestView extends StatelessWidget {
  const SentRequestView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final updatedModel = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider<UserCubit>(
              create: (context) => UserCubit(userModel),
              child: const UserPage(),
            ),
          ),
        );
        debugPrint(updatedModel.toString());
      },
      leading: LargePictureView(uri: userModel.proPicUri),
      title: Text(userModel.username),
      trailing: IconButton(
        onPressed: () =>
            context.read<SentRequestsCubit>().cancelRequest(userModel),
        icon: const Icon(Icons.close),
      ),
    );
  }
}