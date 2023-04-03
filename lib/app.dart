import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:didit/repo/repo_account.dart';
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
        RepositoryProvider<AccountRepository>(
          create: (_) => AccountRepository(),
        ),
        RepositoryProvider<PostRepository>(
          create: (_) => PostRepository(),
        ),
        RepositoryProvider<UserRepository>(
          create: (_) => UserRepository(),
        ),
        RepositoryProvider<CustomCacheManager>(
          create: (_) => CustomCacheManager(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Jumbl',
        theme: themeData,
        routeInformationProvider: goRouter.routeInformationProvider,
        routeInformationParser: goRouter.routeInformationParser,
        routerDelegate: goRouter.routerDelegate,
        //debugShowCheckedModeBanner: false,
      ),
    );
  }
}