import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/domain/bloc/cubit_auth.dart';
import 'package:didit/presentation/widget/view_start.dart';
import 'package:didit/presentation/widget/view_name.dart';
import 'package:didit/presentation/widget/view_age.dart';
import 'package:didit/presentation/widget/view_number.dart';
import 'package:didit/presentation/widget/view_code.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('didit'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 25,
          right: 25,
        ),
        child: BlocConsumer<AuthCubit, AuthState>(
          listenWhen: (previousState, state) {
            if (state is AuthFailure || state is AuthLogin) {
              return true;
            } else {
              return false;
            }
          },
          listener: (context, state) {
            if (state is AuthLogin) {
              FlutterNativeSplash.remove();
              context.pushReplacementNamed('home');
            }
            if (state is AuthFailure) {
              FlutterNativeSplash.remove();
            }
          },
          buildWhen: (previousState, state) {
            if (state is AuthFailure) {
              return false;
            } else {
              return true;
            }
          },
          builder: (context, state) {
            if (state is AuthStart) {
              return const StartView();
            } else if (state is AuthName) {
              return const NameView();
            } else if (state is AuthAge) {
              return const AgeView();
            } else if (state is AuthNumber) {
              return const NumberView();
            } else if (state is AuthCode) {
              return const CodeView();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}