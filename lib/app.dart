import 'package:flutter/material.dart';
import 'package:didit/theme.dart';
import 'package:didit/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MaterialApp.router(
      title: 'didit',
      theme: themeData,
      routerConfig: goRouter,
    );
  }
}