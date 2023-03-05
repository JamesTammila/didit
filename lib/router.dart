import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';
import 'package:didit/feature/auth/page/page_auth.dart';
import 'package:didit/feature/home/bloc/cubit_notifications.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/page/page_home.dart';
import 'package:didit/feature/home/page/page_match.dart';
import 'package:didit/feature/friends/bloc/cubit_pager.dart';
import 'package:didit/feature/friends/bloc/cubit_share.dart';
import 'package:didit/feature/friends/bloc/cubit_suggestions.dart';
import 'package:didit/feature/friends/bloc/cubit_friends.dart';
import 'package:didit/feature/friends/bloc/cubit_requests.dart';
import 'package:didit/feature/friends/bloc/cubit_search.dart';
import 'package:didit/feature/friends/page/page_friends.dart';
import 'package:didit/feature/friends/page/page_search.dart';
import 'package:didit/feature/account/bloc/cubit_account.dart';
import 'package:didit/feature/account/bloc/cubit_edit.dart';
import 'package:didit/feature/account/bloc/cubit_other.dart';
import 'package:didit/feature/account/page/page_account.dart';
import 'package:didit/feature/account/page/page_edit.dart';
import 'package:didit/feature/account/page/page_matching.dart';
import 'package:didit/feature/account/page/page_notifications.dart';
import 'package:didit/feature/account/page/page_privacy.dart';
import 'package:didit/feature/account/page/page_other.dart';
import 'package:didit/feature/account/page/page_help.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/model/model_user.dart';
import 'package:didit/feature/account/page/page_about.dart';
import 'package:didit/feature/user/page/page_user.dart';

final GoRouter goRouter = GoRouter(
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
          BlocProvider<PostsCubit>(
            create: (context) => PostsCubit(
              context.read<PostRepository>(),
            ),
          ),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      name: 'match',
      path: '/match',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<MatchCubit>(
            create: (context) => MatchCubit(
              context.read<PostRepository>(),
            ),
          ),
        ],
        child: const MatchPage(),
      ),
    ),
    GoRoute(
      name: 'friends',
      path: '/friends',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<PagerCubit>(create: (context) => PagerCubit()),
          BlocProvider<ShareCubit>(create: (context) => ShareCubit()),
          BlocProvider<SuggestionsCubit>(
            create: (context) => SuggestionsCubit(
              context.read<UserRepository>(),
            ),
          ),
          BlocProvider<FriendsCubit>(
            create: (context) => FriendsCubit(
              context.read<UserRepository>(),
            ),
          ),
          BlocProvider<RequestsCubit>(
            create: (context) => RequestsCubit(
              context.read<UserRepository>(),
            ),
          ),
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
            BlocProvider<SearchCubit>(
              create: (context) => SearchCubit(
                context.read<UserRepository>(),
              ),
            ),
          ],
          child: const SearchPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: 'account',
      path: '/account',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<AccountCubit>(create: (context) => AccountCubit()),
        ],
        child: const AccountPage(),
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
      builder: (context, state) => BlocProvider<OtherCubit>(
        create: (context) => OtherCubit(),
        child: const OtherPage(),
      ),
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