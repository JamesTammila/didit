import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/account/bloc/cubit_account.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: BlocBuilder<AccountCubit, AccountState>(
          builder: (BuildContext context, state) {
            if (state is AccountLoaded) {
              return Text(state.data['username']);
            } else {
              return const SizedBox();
            }
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.black, Colors.transparent],
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('settings'),
            icon: const Icon(Icons.settings),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: BlocBuilder<AccountCubit, AccountState>(
                builder: (BuildContext context, state) {
                  if (state is AccountLoaded) {
                    return ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                          stops: [0, 0.1],
                          colors: <Color>[Colors.black, Colors.white],
                        ).createShader(bounds);
                      },
                      child: CachedNetworkImage(
                        cacheManager: context.read<CustomCacheManager>(),
                        fit: BoxFit.cover,
                        imageUrl: state.data['url'] ?? '',
                        cacheKey: state.data['url'].split('?')[0],
                        errorWidget: (context, url, error) {
                          if (url.isEmpty) {
                            return Container(
                              color: Color(int.parse(state.data['color'])),
                              alignment: Alignment.center,
                              child: Text(
                                state.data['username'].substring(0, 1).toUpperCase(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 50),
                              ),
                            );
                          } else {
                            return const Center(child: Text('Something went wrong...'));
                          }
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AccountCubit, AccountState>(
              builder: (BuildContext context, state) {
                if (state is AccountLoaded) {
                  final String name = state.data['name'];
                  final String bio = state.data['bio'];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        name.isEmpty ? const SizedBox() : Text(name),
                        SizedBox(height: name.isEmpty || bio.isEmpty ? 0 : 20),
                        bio.isEmpty ? const SizedBox() : Text(bio),
                      ],
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 10),
          ],
        ),
      ),
    );
  }
}