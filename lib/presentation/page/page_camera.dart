import 'package:flutter/material.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          AspectRatio(
            aspectRatio: 4 / 5,
            child: Card(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ],
      ),
    );
  }
}