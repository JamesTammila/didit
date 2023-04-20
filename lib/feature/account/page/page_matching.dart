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
      appBar: AppBar(title: const Text('Ghost Mode')),
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: MediaQuery.of(context).padding.bottom + 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                const SizedBox(height: 10),
                const Text('Enabling ghost mode stops you from getting future '
                    'matches. You can disable it to start matching with '
                    'friends again.'),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Matching'),
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
                const SizedBox(height: 25),
              ],
            ),
            BlocListener<MatchingCubit, MatchingState>(
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
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: FilledButton(
                  onPressed: () => context.read<MatchingCubit>().save(),
                  child: const Text('Save'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}