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
                  textStyle: const TextStyle(color: Colors.black),
                  appContext: context,
                  pinTheme: PinTheme(
                    activeColor: Colors.white,
                    selectedColor: Colors.black,
                    inactiveColor: Colors.white,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
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
                onPressed: () => context.pushReplacementNamed('home'),
                child: const Text("Get Started"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}