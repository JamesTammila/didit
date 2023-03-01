import 'package:flutter/material.dart';
import 'package:didit/common/dialog_soon.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: const [
                  Icon(Icons.file_present_rounded),
                  SizedBox(width: 10),
                  Text('Terms of Service'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => {},
              child: Row(
                children: const [
                  Icon(Icons.file_present_rounded),
                  SizedBox(width: 10),
                  Text('Privacy Policy'),
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
                  Icon(Icons.work),
                  SizedBox(width: 10),
                  Text('Jobs'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}