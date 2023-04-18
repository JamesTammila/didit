import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:didit/repo/repo_account.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/repo/repo_user.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';
import 'package:didit/feature/auth/page/page_auth.dart';
import 'package:didit/feature/home/bloc/cubit_notifications.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/page/page_home.dart';
import 'package:didit/feature/post/bloc/cubit_post.dart';
import 'package:didit/feature/post/page/page_post.dart';
import 'package:didit/feature/friends/bloc/cubit_platform.dart';
import 'package:didit/feature/friends/bloc/cubit_pager.dart';
import 'package:didit/feature/friends/bloc/cubit_share.dart';
import 'package:didit/feature/friends/bloc/cubit_suggestions.dart';
import 'package:didit/feature/friends/bloc/cubit_friends.dart';
import 'package:didit/feature/friends/bloc/cubit_requests.dart';
import 'package:didit/feature/search/bloc/cubit_search.dart';
import 'package:didit/feature/search/bloc/cubit_recent.dart';
import 'package:didit/feature/search/bloc/cubit_filter_friends.dart';
import 'package:didit/feature/search/bloc/cubit_filter_requests.dart';
import 'package:didit/feature/search/bloc/cubit_filter_requests_sent.dart';
import 'package:didit/feature/friends/page/page_friends.dart';
import 'package:didit/feature/search/page/page_search.dart';
import 'package:didit/feature/account/bloc/cubit_account.dart';
import 'package:didit/feature/account/bloc/cubit_memories.dart';
import 'package:didit/feature/account/bloc/cubit_memories_page.dart';
import 'package:didit/feature/account/bloc/cubit_settings.dart';
import 'package:didit/feature/account/bloc/cubit_edit.dart';
import 'package:didit/feature/account/bloc/cubit_matching.dart';
import 'package:didit/feature/account/bloc/cubit_other.dart';
import 'package:didit/feature/account/bloc/cubit_help.dart';
import 'package:didit/feature/account/bloc/cubit_about.dart';
import 'package:didit/feature/account/page/page_account.dart';
import 'package:didit/feature/account/page/page_memories.dart';
import 'package:didit/feature/account/page/page_settings.dart';
import 'package:didit/feature/account/page/page_edit.dart';
import 'package:didit/feature/account/page/page_matching.dart';
import 'package:didit/feature/account/page/page_privacy.dart';
import 'package:didit/feature/account/page/page_other.dart';
import 'package:didit/feature/account/page/page_help.dart';
import 'package:didit/feature/account/page/page_about.dart';
import 'package:didit/feature/user/bloc/cubit_user.dart';
import 'package:didit/feature/user/page/page_user.dart';
import 'package:didit/model/model_user.dart';

final GoRouter goRouter = GoRouter(
  initialLocation: '/auth',
  routes: <GoRoute> [
    GoRoute(
      name: 'auth',
      path: '/auth',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        child: BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..init(),
          child: const AuthPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: 'home',
      path: '/home',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<NotificationsCubit>(
                create: (context) => NotificationsCubit(
                  context.read<PostRepository>(),
                  context.read<UserRepository>(),
                )..init()),
            BlocProvider<PostsCubit>(
              create: (context) => PostsCubit(
                context.read<PostRepository>(),
              )..init(),
            ),
            BlocProvider<MatchCubit>(
              create: (context) => MatchCubit(
                context.read<PostRepository>(),
              )..init(),
            ),
          ],
          child: const HomePage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: 'post',
      path: '/post',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PostCubit>(
              create: (context) => PostCubit(
                context.read<PostRepository>(),
              )..init(),
            ),
          ],
          child: const PostPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    ),
    GoRoute(
      name: 'friends',
      path: '/friends',
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<PlatformCubit>(
                create: (context) => PlatformCubit()..init()),
            BlocProvider<PagerCubit>(create: (context) => PagerCubit()),
            BlocProvider<ShareCubit>(create: (context) => ShareCubit()),
            BlocProvider<SuggestionsCubit>(
              create: (context) => SuggestionsCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
            BlocProvider<FriendsCubit>(
              create: (context) => FriendsCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
            BlocProvider<RequestsCubit>(
              create: (context) => RequestsCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
          ],
          child: const FriendsPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
                position:
                    Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero)
                        .animate(animation),
                child: child),
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
            BlocProvider<RecentCubit>(
              create: (context) => RecentCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
            BlocProvider<SearchCubit>(
              create: (context) => SearchCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
            BlocProvider<FriendsFilterCubit>(
              create: (context) => FriendsFilterCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
            BlocProvider<RequestsFilterCubit>(
              create: (context) => RequestsFilterCubit(
                context.read<UserRepository>(),
              )..init(),
            ),
            BlocProvider<SentRequestsFilterCubit>(
              create: (context) => SentRequestsFilterCubit(
                context.read<UserRepository>(),
              )..init(),
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
      pageBuilder: (context, state) => CustomTransitionPage<void>(
        key: state.pageKey,
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AccountCubit>(
              create: (context) => AccountCubit(
                context.read<AccountRepository>(),
              )..init(),
            ),
            BlocProvider<MemoriesCubit>(
              create: (context) => MemoriesCubit(
                context.read<PostRepository>(),
              )..init(),
            ),
          ],
          child: const AccountPage(),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            SlideTransition(
                position:
                Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
                    .animate(animation),
                child: child),
      ),
    ),
    GoRoute(
      name: 'memories',
      path: '/memories',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<MemoriesPageCubit>(
            create: (context) => MemoriesPageCubit(
              context.read<PostRepository>(),
              state.extra as int,
            )..init(),
          ),
        ],
        child: const MemoryPage(),
      ),
    ),
    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(),
          ),
        ],
        child: const SettingsPage(),
      ),
    ),
    GoRoute(
      name: 'edit',
      path: '/edit',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<EditCubit>(
            create: (context) => EditCubit(
              context.read<AccountRepository>(),
            )..init(),
          ),
        ],
        child: const EditPage(),
      ),
    ),
    GoRoute(
      name: 'matching',
      path: '/matching',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<MatchingCubit>(create: (context) => MatchingCubit()..init()),
        ],
        child: const MatchingPage(),
      ),
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
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<HelpCubit>(
            create: (context) => HelpCubit(),
          ),
        ],
        child: const HelpPage(),
      ),
    ),
    GoRoute(
      name: 'about',
      path: '/about',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<AboutCubit>(
            create: (context) => AboutCubit(),
          ),
        ],
        child: const AboutPage(),
      ),
    ),
    GoRoute(
      name: 'user',
      path: '/user',
      builder: (context, state) => BlocProvider<UserCubit>(
        create: (context) => UserCubit(
          context.read<UserRepository>(),
          state.extra as UserModel,
        )..init(),
        child: const UserPage(),
      ),
    ),
  ],
);