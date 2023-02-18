import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/bloc/cubit_suggestions.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_picture_large.dart';

class SuggestionView extends StatelessWidget {
  const SuggestionView({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 25,
      onTap: () => context.pushNamed('user', extra: userModel),
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