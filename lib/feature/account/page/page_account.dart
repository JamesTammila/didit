import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/account/bloc/cubit_account.dart';
import 'package:didit/feature/account/bloc/cubit_memories.dart';
import 'package:didit/feature/account/widget/view_memories.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(context) {
    final double paddingTop = MediaQuery.of(context).padding.top + kToolbarHeight;
    final double paddingBottom = MediaQuery.of(context).padding.bottom;
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverRefreshControl(
            refreshTriggerPullDistance: paddingTop + 100,
            refreshIndicatorExtent: paddingTop + 100,
            onRefresh: () => context.read<MemoriesCubit>().refreshMemories(),
            builder: (BuildContext context,
                RefreshIndicatorMode refreshState,
                double pulledExtent,
                double refreshTriggerPullDistance,
                double? pulledExtentPercentage) {
              if (refreshState == RefreshIndicatorMode.refresh ||
                  refreshState == RefreshIndicatorMode.armed) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: paddingTop),
                    child: const CircularProgressIndicator(strokeWidth: 1),
                  ),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                AspectRatio(
                  aspectRatio: 4 / 5,
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
                                    state.data['username']
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 50),
                                  ),
                                );
                              } else {
                                return const Center(
                                    child: Text('Something went wrong...'));
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
                BlocBuilder<AccountCubit, AccountState>(
                  builder: (BuildContext context, state) {
                    if (state is AccountLoaded) {
                      final String name = state.data['name'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<AccountCubit, AccountState>(
            builder: (BuildContext context, state) {
              if (state is AccountLoaded) {
                final String bio = state.data['bio'];
                return SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      bio.isEmpty
                          ? const SizedBox()
                          : const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(bio),
                      ),
                      bio.isEmpty
                          ? const SizedBox()
                          : const SizedBox(height: 20),
                    ],
                  ),
                );
              } else {
                return const SliverToBoxAdapter(child: SizedBox());
              }
            },
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 10)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'Your Memories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          const MemoriesView(),
          SliverToBoxAdapter(child: SizedBox(height: paddingBottom)),
        ],
      ),
    );
  }
}