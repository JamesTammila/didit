import 'package:flutter/material.dart';

class MeMenuSheet extends StatelessWidget {
  const MeMenuSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom + 10;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.share),
                SizedBox(width: 15),
                Text('Share Profile (Coming Soon)'),
              ],
            ),
            onPressed: () => {},
          ),
          SizedBox(height: paddingBottom),
        ],
      ),
    );
  }
}