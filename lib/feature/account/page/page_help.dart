import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/account/bloc/cubit_help.dart';

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
              onPressed: () => {},
              child: Row(
                children: const [
                  Icon(Icons.help),
                  SizedBox(width: 10),
                  Text('Help Center (Coming Soon)'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              onPressed: () => context.read<HelpCubit>().openContact(),
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