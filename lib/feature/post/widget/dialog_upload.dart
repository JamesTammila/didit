import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UploadDialog extends StatelessWidget {
  const UploadDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircularProgressIndicator(),
          SizedBox(height: 20),
          Text('Uploading...')
        ],
      ),
    );
  }
}