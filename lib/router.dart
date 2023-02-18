import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_auth.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/domain/bloc/cubit_matches.dart';
import 'package:didit/domain/bloc/cubit_match_current.dart';
import 'package:didit/domain/bloc/cubit_friends_menu.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_suggestions.dart';
import 'package:didit/domain/bloc/cubit_friends.dart';
import 'package:didit/domain/bloc/cubit_requests.dart';
import 'package:didit/domain/bloc/cubit_search.dart';
import 'package:didit/domain/bloc/cubit_profile.dart';
import 'package:didit/domain/bloc/cubit_edit.dart';
import 'package:didit/domain/bloc/cubit_user.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/page/page_auth.dart';
import 'package:didit/presentation/page/page_home.dart';
import 'package:didit/presentation/page/page_match_current.dart';
import 'package:didit/presentation/page/page_friends.dart';
import 'package:didit/presentation/page/page_search.dart';
import 'package:didit/presentation/page/page_profile.dart';
import 'package:didit/presentation/page/page_edit.dart';
import 'package:didit/presentation/page/page_matching.dart';
import 'package:didit/presentation/page/page_notifications.dart';
import 'package:didit/presentation/page/page_privacy.dart';
import 'package:didit/presentation/page/page_other.dart';
import 'package:didit/presentation/page/page_help.dart';
import 'package:didit/presentation/page/page_about.dart';
import 'package:didit/presentation/page/page_user.dart';

final goRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(
      name: 'auth',
      path: '/auth',
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        child: const AuthPage(),
      ),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<NotificationsCubit>(create: (context) => NotificationsCubit()),
          BlocProvider<MatchesCubit>(create: (context) => MatchesCubit()),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      name: 'currentMatch',
      path: '/currentMatch',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<CurrentMatchCubit>(create: (context) => CurrentMatchCubit()),
        ],
        child: const CurrentMatchPage(),
      ),
    ),
    GoRoute(
      name: 'friends',
      path: '/friends',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<MenuFriendsCubit>(create: (context) => MenuFriendsCubit()),
          BlocProvider<ShareCubit>(create: (context) => ShareCubit()),
          BlocProvider<SuggestionsCubit>(create: (context) => SuggestionsCubit()),
          BlocProvider<FriendsCubit>(create: (context) => FriendsCubit()),
          BlocProvider<RequestsCubit>(create: (context) => RequestsCubit()),
        ],
        child: const FriendsPage(),
      ),
    ),
    GoRoute(
      name: 'search',
      path: '/search',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
          ],
          child: const SearchPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        ],
        child: const ProfilePage(),
      ),
    ),
    GoRoute(
      name: 'edit',
      path: '/edit',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<EditCubit>(create: (context) => EditCubit()),
        ],
        child: const EditPage(),
      ),
    ),
    GoRoute(
      name: 'matching',
      path: '/matching',
      builder: (context, state) => const MatchingPage(),
    ),
    GoRoute(
      name: 'notifications',
      path: '/notifications',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      name: 'privacy',
      path: '/privacy',
      builder: (context, state) => const PrivacyPage(),
    ),
    GoRoute(
      name: 'other',
      path: '/other',
      builder: (context, state) => const OtherPage(),
    ),
    GoRoute(
      name: 'help',
      path: '/help',
      builder: (context, state) => const HelpPage(),
    ),
    GoRoute(
      name: 'about',
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),
    GoRoute(
      name: 'user',
      path: '/user',
      builder: (context, state) => BlocProvider<UserCubit>(
        create: (context) => UserCubit(state.extra as UserModel),
        child: const UserPage(),
      ),
    ),
  ],
);