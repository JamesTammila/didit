import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:didit/domain/bloc/cubit_auth.dart';

class PhoneNumberView extends StatelessWidget {
  const PhoneNumberView({super.key});

  @override
  Widget build(context) {
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
                    context.read<AuthCubit>().setValid(isValid),
                onInputChanged: (number) =>
                    context.read<AuthCubit>().setNumber(number.phoneNumber),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => {},
                    child: const Text("Back"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: () => context.read<AuthCubit>().authenticate(),
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