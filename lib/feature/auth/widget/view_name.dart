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
                          initialValue: state.name,
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          decoration: const InputDecoration(hintText: 'Name'),
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
        FloatingActionButton(
          onPressed: () => context.read<AuthCubit>().goAge(),
          child: const Text('Continue'),
        ),
      ],
    );
  }
}