import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/domain/bloc/cubit_friends_menu.dart';
import 'package:didit/presentation/widget/view_suggestions.dart';
import 'package:didit/presentation/widget/view_friends.dart';
import 'package:didit/presentation/widget/view_requests.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({super.key});

  @override
  FriendsPageState createState() => FriendsPageState();
}

class FriendsPageState extends State<FriendsPage> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: const Text('Friends'),
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
      body: PageView(
        controller: pageController,
        children: const [
          SuggestionsView(),
          RequestsView(),
          FriendsView(),
        ],
        onPageChanged: (i) => context.read<MenuFriendsCubit>().set(i),
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
          currentIndex: context.watch<MenuFriendsCubit>().state,
          onTap: (i) {
            context.read<MenuFriendsCubit>().set(i);
            pageController.animateToPage(
              i,
              duration: const Duration(milliseconds: 250),
              curve: Curves.linear,
            );
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(null), label: 'Suggestions'),
            BottomNavigationBarItem(icon: Icon(null), label: 'Requests'),
            BottomNavigationBarItem(icon: Icon(null), label: 'Friends'),
          ],
        ),
      ),
    );
  }
}