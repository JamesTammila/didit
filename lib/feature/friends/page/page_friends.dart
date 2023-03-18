import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/feature/friends/bloc/cubit_platform.dart';
import 'package:didit/feature/friends/bloc/cubit_pager.dart';
import 'package:didit/feature/friends/widget/view_suggestions.dart';
import 'package:didit/feature/friends/widget/view_friends.dart';
import 'package:didit/feature/friends/widget/view_requests.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  FriendsPageState createState() => FriendsPageState();
}

class FriendsPageState extends State<FriendsPage> {
  final PageStorageBucket bucket = PageStorageBucket();
  final PageController controller = PageController(initialPage: 1);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: TextField(
            readOnly: true,
            onTap: () => context.pushNamed('search'),
            decoration: const InputDecoration(
              icon: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Icon(Icons.search),
              ),
              hintText: 'Search or Find Friends',
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () => context.pop(),
              icon: BlocBuilder<PlatformCubit, PlatformState>(
                builder: (context, state) {
                  if (state is PlatformIOS) {
                    return const Icon(Icons.arrow_forward_ios);
                  } else if (state is PlatformAndroid) {
                    return const Icon(Icons.arrow_forward);
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
        ],
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
      body: PageStorage(
        bucket: bucket,
        child: PageView(
          padEnds: false,
          controller: controller,
          children: const [
            SuggestionsView(),
            FriendsView(),
            RequestsView(),
          ],
          onPageChanged: (i) => context.read<PagerCubit>().set(i),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[Colors.black, Colors.transparent],
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: context.watch<PagerCubit>().state,
          onTap: (i) {
            context.read<PagerCubit>().set(i);
            controller.animateToPage(
              i,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear,
            );
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(null), label: 'Suggestions'),
            BottomNavigationBarItem(icon: Icon(null), label: 'Friends'),
            BottomNavigationBarItem(icon: Icon(null), label: 'Requests'),
          ],
        ),
      ),
    );
  }
}