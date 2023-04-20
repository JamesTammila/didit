import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/util/formatter_time.dart';
import 'package:didit/feature/home/bloc/cubit_item_post.dart';
import 'package:didit/feature/home/widget/view_picture_medium.dart';

class PostSheet extends StatelessWidget {
  const PostSheet({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom + 10;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              formatTime(postModel.createdAt),
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Card(
            child: SizedBox(
              height: 264,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                itemCount: postModel.medias.length,
                itemBuilder: (context, i) {
                  return SizedBox(
                    height: 66,
                    child: ListTile(
                      onTap: () => context.pushNamed('user',
                          extra: postModel.medias[i].user),
                      leading: MediumPictureView(
                          userModel: postModel.medias[i].user),
                      title: Text(postModel.medias[i].user.username),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () => context.read<PostItemCubit>().sharePost(postModel),
            child: Row(
              children: const [
                Icon(Icons.share),
                SizedBox(width: 15),
                Text('Share Post (Coming Soon)'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            onPressed: () =>
                context.read<PostItemCubit>().reportPost(postModel),
            child: Row(
              children: const [
                Icon(Icons.report, color: Colors.red),
                SizedBox(width: 15),
                Text('Report Post (Coming Soon)',
                    style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
        ),
        SizedBox(height: paddingBottom),
      ],
    );
  }
}