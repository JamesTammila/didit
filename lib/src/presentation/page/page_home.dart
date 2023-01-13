import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/src/domain/bloc/cubit_page_home.dart';
import 'package:didit/src/presentation/widget/view_post.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pushNamed('Friends'),
          icon: const Icon(Icons.people_alt_rounded),
        ),
        title: const Text('DidIt'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('Settings'),
            icon: const Icon(Icons.settings_rounded),
          ),
        ],
      ),
      body: BlocConsumer<HomePageCubit, HomePageState>(
        buildWhen: (previousState, state) {
          if (state is Loading || state is Loaded || state is Empty) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: state.posts.length,
              itemBuilder: (context, i) {
                return PostView(postModel: state.posts[i]);
              },
            );
          } else if (state is Empty) {
            return const Center(child: Text("No Posts"));
          } else if (state is Error) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
        listenWhen: (previousState, state) {
          return false;
        },
        listener: (context, state) {},
      ),
    );
  }
}