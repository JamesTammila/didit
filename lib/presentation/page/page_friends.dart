import 'package:flutter/material.dart';
import 'package:didit/presentation/widget/view_suggestions.dart';
import 'package:didit/presentation/widget/view_friends.dart';
import 'package:didit/presentation/widget/view_requests.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: PageView(
          children: const [
            SuggestionsView(),
            RequestsView(),
            FriendsView(),
          ],
        ),
      ),
    );
  }
}