import 'package:didit/feature/auth/bloc/cubit_pager_intro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  IntroViewState createState() => IntroViewState();
}


class IntroViewState extends State<IntroView> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: PageView(
            allowImplicitScrolling: true,
            controller: controller,
            onPageChanged: (i) => context.read<IntroPagerCubit>().set(i),
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '4 Notifications | 1 Match',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Every day you match with three friends.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/intro_1.png', fit: BoxFit.contain),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '4 Friends | 1 Caption',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Everyone gets the same caption.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/intro_2.png', fit: BoxFit.contain),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '4 Photos | 1 Post',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Everyone shares one photo.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/intro_3.png', fit: BoxFit.contain),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Start sharing together!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  Image.asset('assets/intro_4.png', fit: BoxFit.contain),
                ],
              ),
            ],
          ),
        ),
        Center(
          child: SizedBox(
            height: 50,
            child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BlocBuilder<IntroPagerCubit, int>(
                    builder: (context, state) {
                      if (state == i) {
                        return const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.blue,
                        );
                      } else {
                        return const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.grey,
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: FloatingActionButton(
            onPressed: () {
              context.read<IntroPagerCubit>().set(0);
              context.read<AuthCubit>().goName();
            },
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }
}