import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/src/domain/bloc/cubit_page_auth.dart';
import 'package:didit/src/domain/bloc/cubit_page_home.dart';
import 'package:didit/src/domain/bloc/cubit_page_profile.dart';
import 'package:didit/src/domain/bloc/cubit_page_friends.dart';
import 'package:didit/src/domain/bloc/cubit_page_settings.dart';
import 'package:didit/src/domain/model/model_user.dart';
import 'package:didit/src/presentation/page/page_auth.dart';
import 'package:didit/src/presentation/page/page_home.dart';
import 'package:didit/src/presentation/page/page_profile.dart';
import 'package:didit/src/presentation/page/page_friends.dart';
import 'package:didit/src/presentation/page/page_settings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'DidIt',
      theme: ThemeData(
        useMaterial3: true,
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
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          titleSpacing: 10,
        ),
        dialogTheme: const DialogTheme(
          titleTextStyle: TextStyle(
            fontSize: 16,
          ),
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
            name: 'Auth',
            path: '/Auth',
            builder: (context, state) => BlocProvider<AuthPageCubit>(
              create: (context) => AuthPageCubit(),
              child: const AuthPage(),
            ),
          ),
          GoRoute(
            name: 'Home',
            path: '/Home',
            builder: (context, state) => BlocProvider<HomePageCubit>(
              create: (context) => HomePageCubit(),
              child: const HomePage(),
            ),
          ),
          GoRoute(
            name: 'Profile',
            path: '/Profile',
            builder: (context, state) => BlocProvider<ProfilePageCubit>(
              create: (context) => ProfilePageCubit(),
              child: ProfilePage(model: state.extra as UserModel),
            ),
          ),
          GoRoute(
            name: 'Friends',
            path: '/Friends',
            builder: (context, state) => BlocProvider<FriendsPageCubit>(
              create: (context) => FriendsPageCubit(),
              child: const FriendsPage(),
            ),
          ),
          GoRoute(
            name: 'Settings',
            path: '/Settings',
            builder: (context, state) => BlocProvider<SettingsPageCubit>(
              create: (context) => SettingsPageCubit(),
              child: const SettingsPage(),
            ),
          ),
        ],
      ),
    );
  }
}