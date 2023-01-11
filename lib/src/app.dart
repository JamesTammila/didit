import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/src/data/client/client_auth.dart';
import 'package:didit/src/data/client/client_database.dart';
import 'package:didit/src/data/client/client_web.dart';
import 'package:didit/src/domain/bloc/cubit_page_home.dart';
import 'package:didit/src/domain/bloc/cubit_page_settings.dart';
import 'package:didit/src/presentation/page/page_home.dart';
import 'package:didit/src/presentation/page/page_settings.dart';

class App extends StatelessWidget {
  App({super.key});

  final AuthClient authClient = AuthClient();
  final DatabaseClient databaseClient = DatabaseClient();
  final WebClient webClient = WebClient();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DidIt',
      theme: ThemeData(
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.black,
          secondary: Colors.white,
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.white,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          clipBehavior: Clip.hardEdge,
          elevation: 0,
        ),
        cardTheme: const CardTheme(
          clipBehavior: Clip.hardEdge,
          elevation: 5,
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: '/Home',
        routes: [
          GoRoute(
            name: 'Home',
            path: '/Home',
            builder: (context, state) => BlocProvider<HomePageCubit>(
              create: (context) => HomePageCubit(databaseClient),
              child: const HomePage(),
            ),
          ),
          GoRoute(
            name: 'Settings',
            path: '/Settings',
            builder: (context, state) => BlocProvider<SettingsPageCubit>(
              create: (context) => SettingsPageCubit(authClient, webClient),
              child: const SettingsPage(),
            ),
          ),
        ],
      ),
    );
  }
}