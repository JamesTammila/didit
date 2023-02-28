import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/auth/domain/bloc/cubit_auth.dart';

class AgeView extends StatelessWidget {
  const AgeView({super.key});

  @override
  Widget build(context) {
    final bloc = context.read<AuthCubit>();
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Enter your birthday:"),
              const SizedBox(height: 50),
              CupertinoButton(
                onPressed: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: SizedBox(
                      height: 300,
                      child: CupertinoDatePicker(
                        backgroundColor: Colors.black,
                        initialDateTime: bloc.age,
                        mode: CupertinoDatePickerMode.date,
                        use24hFormat: true,
                        onDateTimeChanged: (DateTime newDate) {
                          bloc.setAge(newDate);
                        },
                      ),
                    ),
                  ),
                ),
                child: BlocBuilder<AuthCubit, AuthState>(
                  buildWhen: (previousState, state) {
                    if (state is AuthAge) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthAge) {
                      return Text(
                        state.displayAge,
                        style: const TextStyle(fontSize: 20),
                      );
                    } else {
                      return const SizedBox();
                    }
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
                onPressed: () => context.read<AuthCubit>().goName(),
                child: const Text("Back"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                onPressed: () => context.read<AuthCubit>().goNumber(),
                child: const Text("Continue"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}