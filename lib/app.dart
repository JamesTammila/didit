import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/theme.dart';
import 'package:didit/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
      ],
      child: MaterialApp.router(
        title: 'didit',
        theme: themeData,
        routerConfig: goRouter,
      ),
    );
  }
}