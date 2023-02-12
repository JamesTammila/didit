import 'package:flutter/material.dart';
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
  int currentPageIndex = 0;

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
        onPageChanged: (i) {
          setState(() {
            currentPageIndex = i;
          });
        },
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
          iconSize: 0,
          currentIndex: currentPageIndex,
          onTap: (i) {
            setState(() {
              currentPageIndex = i;
            });
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