import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';

class UsernameView extends StatelessWidget {
  const UsernameView({super.key});

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Pick a username:'),
              const SizedBox(height: 50),
              BlocBuilder<AuthCubit, AuthState>(
                buildWhen: (previousState, state) {
                  if (state is AuthUsername) {
                    return true;
                  } else {
                    return false;
                  }
                },
                builder: (context, state) {
                  if (state is AuthUsername) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.15),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextFormField(
                          initialValue: state.username,
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          decoration:
                              const InputDecoration(hintText: 'Username'),
                          onChanged: (s) =>
                              context.read<AuthCubit>().setUsername(s),
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
                onPressed: () => context.read<AuthCubit>().goCode(),
                child: const Text('Back'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FloatingActionButton(
                onPressed: () => context.read<AuthCubit>().authenticate(),
                child: const Text('Get Started'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}