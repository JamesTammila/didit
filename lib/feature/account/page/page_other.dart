import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/account/bloc/cubit_other.dart';
import 'package:didit/feature/account/widget/dialog_delete_account.dart';
import 'package:didit/common/dialog_soon.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<OtherCubit>();
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
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: bloc,
                      child: const DeleteAccountDialog(),
                    ),
                  ),
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