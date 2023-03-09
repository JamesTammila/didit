import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/util/theme.dart';
import 'package:didit/util/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PostRepository>(
          create: (context) => PostRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<CustomCacheManager>(
          create: (context) => CustomCacheManager(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Jumbl',
        theme: themeData,
        routerConfig: goRouter,
      ),
    );
  }
}