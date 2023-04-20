import 'package:flutter/material.dart';

class RandomMenuSheet extends StatelessWidget {
  const RandomMenuSheet({super.key});

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
          const SizedBox(height: 5),
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.block, color: Colors.red),
                SizedBox(width: 15),
                Text(
                  'Block User (Coming Soon)',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
            onPressed: () => {},
          ),
          const SizedBox(height: 5),
          ElevatedButton(
            child: Row(
              children: const [
                Icon(Icons.report, color: Colors.red),
                SizedBox(width: 15),
                Text(
                  'Report User (Coming Soon)',
                  style: TextStyle(color: Colors.red),
                ),
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