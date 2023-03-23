import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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