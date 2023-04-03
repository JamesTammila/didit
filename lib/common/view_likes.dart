import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:didit/common/cubit_likes.dart';
import 'package:didit/common/item_likes.dart';

class LikesView extends StatelessWidget {
  const LikesView({super.key});

  @override
  Widget build(context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Card(color: Colors.white, child: SizedBox(height: 5, width: 50)),
        const SizedBox(height: 20),
        const Center(child: Text('Likes')),
        const SizedBox(height: 20),
        const Divider(),
        BlocBuilder<LikesCubit, LikesState>(
          builder: (context, state) {
            if (state is LikesLoading) {
              return const Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(strokeWidth: 1),
              );
            } else if (state is LikesLoaded) {
              return Flexible(
                child: ListView.builder(
                  itemCount: state.likes.length,
                  itemBuilder: (context, i) {
                    return LikesItem(
                      userModel: state.likes.values.elementAt(i),
                    );
                  },
                ),
              );
            } else if (state is LikesEmpty) {
              return const SizedBox(
                width: double.infinity,
                child: Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child:  Text(
                      'No Likes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            } else if (state is LikesError) {
              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Center(
                    child: Text(
                      state.error,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}