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
    final double paddingBottom = MediaQuery.of(context).padding.bottom + 15;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Card(color: Colors.white, child: SizedBox(height: 5, width: 50)),
        const SizedBox(height: 20),
        Center(
          child: Text(
            formatTime(postModel.createdAt),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 20),
        const Divider(),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
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
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
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