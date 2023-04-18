import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: const [
                  Icon(Icons.block),
                  SizedBox(width: 10),
                  Text('Blocked Users (Coming Soon)'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}