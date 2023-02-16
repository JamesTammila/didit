import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:didit/domain/bloc/cubit_auth.dart';

class CodeView extends StatelessWidget {
  const CodeView({super.key});

  @override
  Widget build(context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Enter your code:"),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  appContext: context,
                  pinTheme: PinTheme(
                    fieldHeight: 50,
                    fieldWidth: 40,
                    shape: PinCodeFieldShape.box,
                  ),
                  enableActiveFill: true,
                  animationType: AnimationType.scale,
                  animationDuration: const Duration(milliseconds: 300),
                  length: 6,
                  //errorAnimationController: errorController,
                  onChanged: (value) {},
                  onCompleted: (s) => context.read<AuthCubit>().setCode(s),
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => context.read<AuthCubit>().goNumber(),
                child: const Text("Back"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                onPressed: () => context.pushNamed('home'),
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}