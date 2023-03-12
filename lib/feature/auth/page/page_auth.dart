import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/auth/bloc/cubit_auth.dart';
import 'package:didit/feature/auth/widget/view_username.dart';
import 'package:didit/feature/auth/widget/view_name.dart';
import 'package:didit/feature/auth/widget/view_age.dart';
import 'package:didit/feature/auth/widget/view_number.dart';
import 'package:didit/feature/auth/widget/view_code.dart';
import 'package:didit/common/dialog_error.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Jumbl'),
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
              if (state.error == 'Username Taken') {
                showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(error: state.error),
                );
              } else if (state.error == 'SESSION'){
                context.pushReplacementNamed('home');
              } else {
                showDialog(
                  context: context,
                  builder: (context) => ErrorDialog(error: state.error),
                );
              }
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
            if (state is AuthName) {
              return const NameView();
            } else if (state is AuthAge) {
              return const AgeView();
            } else if (state is AuthNumber) {
              return const NumberView();
            } else if (state is AuthCode) {
              return const CodeView();
            } else if (state is AuthUsername) {
              return const UsernameView();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}