import 'package:didit/feature/home/domain/bloc/cubit_user.dart';
import 'package:didit/feature/home/presentation/page/page_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/friends/domain/bloc/cubit_suggestions.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/feature/friends/presentation/widget/view_picture_large.dart';

class SuggestionView extends StatelessWidget {
  const SuggestionView({super.key, required this.userModel});

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
      trailing: TextButton(
        onPressed: () =>
            context.read<SuggestionsCubit>().sendRequest(userModel),
        child: const Text('ADD'),
      ),
    );
  }
}