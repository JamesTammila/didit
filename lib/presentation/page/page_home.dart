import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_page_home.dart';
import 'package:didit/domain/model/model_user.dart';
import 'package:didit/presentation/widget/view_match.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(context) {
    FlutterNativeSplash.remove();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.transparent],
            ),
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => context.pushNamed('Friends'),
          icon: const Icon(Icons.people_alt_rounded),
        ),
        title: const Text('DidIt'),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(
              'Profile',
              extra: const UserModel(
                objectId: '',
                createdAt: '',
                username: 'James',
                proPicUri:
                    'https://pop.inquirer.net/files/2021/05/gigachad.jpg',
                friendState: '',
                requestId: '',
              ),
            ),
            icon: const Icon(Icons.person_rounded),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FilledButton(
        onPressed: () => {},
        child: const Icon(Icons.groups),
      ),
      body: BlocConsumer<HomePageCubit, HomePageState>(
        buildWhen: (previousState, state) {
          if (state is Loading ||
              state is Loaded ||
              state is Empty ||
              state is Error) {
            return true;
          } else {
            return false;
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is Loaded) {
            return ListView.builder(
              itemCount: state.matches.length,
              itemBuilder: (context, i) {
                return MatchView(matchModel: state.matches[i]);
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
          if (state is Denied) {
            return true;
          } else {
            return false;
          }
        },
        listener: (context, state) {
          if (state is Denied) {
            showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text("Notification Permission"),
                content: const Text("We need to request your permission to "
                    "enable notifications."),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    child: const Text("Accept"),
                    onPressed: () {
                      Navigator.pop(context);
                      context.read<HomePageCubit>().openSettings();
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}