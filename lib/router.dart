import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_auth.dart';
import 'package:didit/domain/bloc/cubit_notifications.dart';
import 'package:didit/domain/bloc/cubit_posts.dart';
import 'package:didit/domain/bloc/cubit_share.dart';
import 'package:didit/domain/bloc/cubit_suggestions.dart';
import 'package:didit/domain/bloc/cubit_friends.dart';
import 'package:didit/domain/bloc/cubit_requests.dart';
import 'package:didit/domain/bloc/cubit_page_profile.dart';
import 'package:didit/domain/bloc/cubit_user.dart';
import 'package:didit/domain/bloc/cubit_page_settings.dart';
import 'package:didit/domain/bloc/cubit_media.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/domain/model/model_media.dart';
import 'package:didit/presentation/page/page_auth.dart';
import 'package:didit/presentation/page/page_home.dart';
import 'package:didit/presentation/page/page_profile.dart';
import 'package:didit/presentation/page/page_friends.dart';
import 'package:didit/presentation/page/page_settings.dart';
import 'package:didit/presentation/page/page_user.dart';
import 'package:didit/presentation/page/page_media.dart';

final goRouter = GoRouter(
  initialLocation: '/home',
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
          BlocProvider<PostsCubit>(create: (context) => PostsCubit()),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      name: 'friends',
      path: '/friends',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<ShareCubit>(create: (context) => ShareCubit()),
          BlocProvider<SuggestionsCubit>(create: (context) => SuggestionsCubit()),
          BlocProvider<FriendsCubit>(create: (context) => FriendsCubit()),
          BlocProvider<RequestsCubit>(create: (context) => RequestsCubit()),
        ],
        child: const FriendsPage(),
      ),
    ),
    GoRoute(
      name: 'profile',
      path: '/profile',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<ProfilePageCubit>(create: (context) => ProfilePageCubit()),
        ],
        child: const ProfilePage(),
      ),
    ),
    // Camera




    GoRoute(
      name: 'settings',
      path: '/settings',
      builder: (context, state) => BlocProvider<SettingsPageCubit>(
        create: (context) => SettingsPageCubit(),
        child: const SettingsPage(),
      ),
    ),



    GoRoute(
      name: 'user',
      path: '/user',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(state.extra as UserModel),
          ),
        ],
        child: const UserPage(),
      ),
    ),
    GoRoute(
      name: 'media',
      path: '/media',
      builder: (context, state) => BlocProvider<MediaCubit>(
        create: (context) => MediaCubit(),
        child: MediaPage(mediaModel: state.extra as MediaModel),
      ),
    ),
  ],
);