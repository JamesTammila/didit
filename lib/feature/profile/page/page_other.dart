import 'package:didit/common/dialog_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/profile/bloc/cubit_other.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(context) {
    return BlocListener<OtherCubit, OtherState>(
      listener: (context, state) {
        if (state is OtherExit) {
          context.pop();
          context.pop();
          context.pushReplacementNamed('auth');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Other')),
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
                    Icon(Icons.delete_forever),
                    SizedBox(width: 10),
                    Text('Delete Cache'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Card(
                child: InkWell(
                  onTap: () => context.read<OtherCubit>().deleteUser(),
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
      ),
    );
  }
}