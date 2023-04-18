import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/account/bloc/cubit_settings.dart';
import 'package:didit/common/dialog_error.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(context) {
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state is SettingsExit) {
          context.pop();
          context.pop();
          context.pushReplacementNamed('auth');
        }
        if (state is SettingsError) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(error: state.error),
          );
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Settings'),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.black, Colors.transparent],
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + kToolbarHeight + 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: InkWell(
                    onTap: () => context.pushNamed('edit'),
                    child: SizedBox(
                      height: 50,
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(Icons.edit),
                          SizedBox(width: 10),
                          Text('Edit Profile'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text('Settings'),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => context.pushNamed('matching'),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.person_off),
                              SizedBox(width: 10),
                              Text('Ghost Mode'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () => context.pushNamed('privacy'),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.remove_red_eye),
                              SizedBox(width: 10),
                              Text('Privacy'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () => context.pushNamed('other'),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.settings),
                              SizedBox(width: 10),
                              Text('Other'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text('About'),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => context.read<SettingsCubit>().shareLink(),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.share),
                              SizedBox(width: 10),
                              Text('Share Jumbl'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () => {},
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.star_rate),
                              SizedBox(width: 10),
                              Text('Rate Jumbl (Coming Soon)'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () => context.pushNamed('help'),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.help),
                              SizedBox(width: 10),
                              Text('Help'),
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      InkWell(
                        onTap: () => context.pushNamed('about'),
                        child: SizedBox(
                          height: 50,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Icon(Icons.info),
                              SizedBox(width: 10),
                              Text('About'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: InkWell(
                    onTap: () => context.read<SettingsCubit>().logout(),
                    child: const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
            ],
          ),
        ),
      ),
    );
  }
}