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
      appBar: AppBar(title: const Text('Friends')),
      body: ShaderMask(
        shaderCallback: (Rect bounds) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.center,
            stops: [0, 0.25],
            colors: <Color>[Colors.black, Colors.white],
            tileMode: TileMode.mirror,
          ).createShader(bounds);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: PageView(
            children: const [
              SuggestionsView(),
              RequestsView(),
              FriendsView(),
            ],
          ),
        ),
      ),
    );
  }
}