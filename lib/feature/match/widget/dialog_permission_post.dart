import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/common/cubit_appsettings.dart';

class CameraPostDialog extends StatelessWidget {
  const CameraPostDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Camera Permission'),
      content: const Text('We need permission to access your camera so you '
          'can post.'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () {
            Navigator.pop(context);
            context.read<AppSettingsCubit>().openSettings();
          },
        ),
      ],
    );
  }
}