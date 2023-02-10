import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Other')),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              child: InkWell(
                onTap: () => {},
                child: const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Delete Account',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}