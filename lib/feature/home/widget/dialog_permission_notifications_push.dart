import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/common/cubit_appsettings.dart';

class PushNotificationsDialog extends StatelessWidget {
  const PushNotificationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Notifications Permission'),
      content: const Text('We need permission to enable notifications so you '
          'can start matching.'),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Cancel'),
          onPressed: () => context.pop(),
        ),
        CupertinoButton(
          child: const Text('OK'),
          onPressed: () {
            context.pop();
            context.read<AppSettingsCubit>().openSettings();
          },
        ),
      ],
    );
  }
}