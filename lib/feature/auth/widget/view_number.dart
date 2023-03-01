import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';

class NumberView extends StatelessWidget {
  const NumberView({super.key});

  @override
  Widget build(context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Enter your phone number:"),
              const SizedBox(height: 50),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previousState, state) {
                  if (state is AuthNumber) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is AuthNumber) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: SizedBox(
                        height: 100,
                        child: InternationalPhoneNumberInput(
                          initialValue: state.phoneNumber,
                          inputBorder: InputBorder.none,
                          selectorButtonOnErrorPadding: 0,
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.DIALOG,
                            useEmoji: true,
                          ),
                          errorMessage: 'Invalid Number',
                          onInputValidated: (isValid) =>
                              context.read<AuthCubit>().setValid(isValid),
                          onInputChanged: (number) => context
                              .read<AuthCubit>()
                              .setNumber(number),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () => context.read<AuthCubit>().goAge(),
                child: const Text("Back"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                onPressed: () => context.read<AuthCubit>().verify(),
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}