import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:didit/src/domain/bloc/cubit_page_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("Enter your phone number:"),
            const SizedBox(height: 20),
            SizedBox(
              height: 100,
              child: InternationalPhoneNumberInput(
                inputBorder: InputBorder.none,
                selectorButtonOnErrorPadding: 0,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                  useEmoji: true,
                ),
                onInputValidated: (isValid) =>
                    context.read<AuthPageCubit>().setValid(isValid),
                onInputChanged: (number) =>
                    context.read<AuthPageCubit>().setNumber(number.phoneNumber),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => context.pop(),
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () =>
                        context.read<AuthPageCubit>().authenticate(),
                    child: const Text("Continue"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}