import 'package:flutter/cupertino.dart';

class SoonDialog extends StatelessWidget {
  const SoonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoAlertDialog(
      title: Text('Coming Soon!'),
    );
  }
}