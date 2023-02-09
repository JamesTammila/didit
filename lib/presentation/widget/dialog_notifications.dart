import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';

class NotificationsDialog extends StatelessWidget {
  const NotificationsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Notification Permission'),
      content: const Text('We need to request your permission to '
          'enable notifications.'),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('Accept'),
          onPressed: () {
            Navigator.pop(context);
            context.read<NotificationsCubit>().openSettings();
          },
        ),
      ],
    );
  }
}