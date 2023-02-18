import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_auth.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  StartViewState createState() => StartViewState();
}

class StartViewState extends State<StartView> {
  final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            controller: controller,
            children: const [
              Center(child: Text('Page 1')),
              Center(child: Text('Page 2')),
              Center(child: Text('Page 3')),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => context.read<AuthCubit>().goName(),
                child: const Text('Skip'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                onPressed: () {
                  if (controller.page == 2) {
                    context.read<AuthCubit>().goName();
                  } else {
                    controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear,
                    );
                  }
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}