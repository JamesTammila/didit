import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/account/bloc/cubit_matching.dart';
import 'package:didit/common/dialog_error.dart';

class MatchingPage extends StatelessWidget {
  const MatchingPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Match Settings')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Enable Matching'),
                BlocBuilder<MatchingCubit, MatchingState>(
                  buildWhen: (previousState, state) {
                    if (state is MatchingInit || state is MatchingLoaded) {
                      return true;
                    } else {
                      return false;
                    }
                  },
                  builder: (BuildContext context, state) {
                    if (state is MatchingLoaded) {
                      return CupertinoSwitch(
                        value: state.isMatching,
                        onChanged: (bool value) =>
                            context.read<MatchingCubit>().setMatching(value),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: BlocListener(
              listenWhen: (previousState, state) {
                if (state is MatchingSaved || state is MatchingError) {
                  return true;
                } else {
                  return false;
                }
              },
              listener: (BuildContext context, state) {
                if (state is MatchingSaved) {
                  context.pop();
                } else if (state is MatchingError) {
                  showDialog(
                    context: context,
                    builder: (context) => ErrorDialog(error: state.error),
                  );
                }
              },
              child: FilledButton(
                onPressed: () => context.read<MatchingCubit>().save(),
                child: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}