import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';

class NameView extends StatelessWidget {
  const NameView({super.key});

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Enter your first name:'),
              const SizedBox(height: 50),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previousState, state) {
                  if (state is AuthName) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is AuthName) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          maxLength: 30,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          initialValue: state.name,
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          decoration: const InputDecoration(
                            hintText: 'Name',
                            counter: SizedBox(),
                            contentPadding: EdgeInsets.only(top: 5),
                          ),
                          onChanged: (s) => context.read<AuthCubit>().setName(s),
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
                onPressed: () => context.read<AuthCubit>().goIntro(),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                onPressed: () => context.read<AuthCubit>().goAge(),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}