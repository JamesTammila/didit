import 'package:flutter/material.dart';
import 'package:didit/common/dialog_soon.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const SoonDialog(),
              ),
              child: Row(
                children: const [
                  Icon(Icons.help),
                  SizedBox(width: 10),
                  Text('Help Center'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) => const SoonDialog(),
              ),
              child: Row(
                children: const [
                  Icon(Icons.email),
                  SizedBox(width: 10),
                  Text('Contact Us'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}