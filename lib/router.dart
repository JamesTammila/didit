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
import 'package:didit/domain/bloc/cubit_page_settings.dart';
import 'package:didit/domain/bloc/cubit_media.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/domain/model/model_media.dart';
import 'package:didit/presentation/page/page_auth.dart';
import 'package:didit/presentation/page/page_home.dart';
import 'package:didit/presentation/page/page_profile.dart';
import 'package:didit/presentation/page/page_friends.dart';
import 'package:didit/presentation/page/page_settings.dart';
import 'package:didit/presentation/page/page_media.dart';

final goRouter = GoRouter(
  initialLocation: '/Home',
  routes: [
    GoRoute(
      name: 'Auth',
      path: '/Auth',
      builder: (context, state) => BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(),
        child: const AuthPage(),
      ),
    ),
    GoRoute(
      name: 'Home',
      path: '/Home',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<NotificationsCubit>(create: (context) => NotificationsCubit()),
          BlocProvider<PostsCubit>(create: (context) => PostsCubit()),
        ],
        child: const HomePage(),
      ),
    ),
    GoRoute(
      name: 'Friends',
      path: '/Friends',
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
      name: 'Profile',
      path: '/Profile',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<ProfilePageCubit>(
            create: (context) => ProfilePageCubit(state.extra as UserModel),
          ),
        ],
        child: const ProfilePage(),
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
    GoRoute(
      name: 'Media',
      path: '/Media',
      builder: (context, state) => BlocProvider<MediaCubit>(
        create: (context) => MediaCubit(),
        child: MediaPage(mediaModel: state.extra as MediaModel),
      ),
    ),
    // Camera
    // User
  ],
);