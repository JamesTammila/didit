import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/friends/bloc/cubit_share.dart';
import 'package:didit/common/dialog_error.dart';

class ShareView extends StatelessWidget {
  const ShareView({super.key});

  @override
  Widget build(context) {
    return BlocListener<ShareCubit, ShareState>(
      listener: (context, state) {
        if (state is ShareError) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(error: state.error),
          );
        }
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => context.read<ShareCubit>().shareLink(),
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: ListTile(
              title: Text('Invite your friends to didit!'),
              trailing: Icon(Icons.share),
            ),
          ),
        ),
      ),
    );
  }
}