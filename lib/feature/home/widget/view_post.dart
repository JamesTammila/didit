import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/feature/home/bloc/cubit_posts.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/feature/home/widget/view_picture_small.dart';
import 'package:didit/feature/home/widget/view_picture_medium.dart';

class PostView extends StatefulWidget {
  const PostView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  PostViewState createState() => PostViewState();
}

class PostViewState extends State<PostView> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: ListView.builder(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: widget.postModel.medias.length,
            itemBuilder: (context, i) {
              return InkWell(
                onTap: () => context.pushNamed('user',
                    extra: widget.postModel.medias[i].user),
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: BlocBuilder<PagerCubit, int>(
                    builder: (context, state) {
                      if (state == i) {
                        return MediumPictureView(
                          url: widget.postModel.medias[i].user.getUrl,
                        );
                      } else {
                        return SmallPictureView(
                          url: widget.postModel.medias[i].user.getUrl,
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
          title: BlocBuilder<PagerCubit, int>(
            builder: (context, state) {
              return Text(widget.postModel.medias[state].user.username);
            },
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: PageView.builder(
                allowImplicitScrolling: true,
                controller: controller,
                itemCount: widget.postModel.medias.length,
                onPageChanged: (i) => context.read<PagerCubit>().swipePage(i),
                itemBuilder: (context, i) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.postModel.medias[i].getUrl,
                    cacheKey: widget.postModel.medias[i].getUrl.split('?')[0],
                    progressIndicatorBuilder: (context, url, progress) => Center(
                        child: CircularProgressIndicator(value: progress.progress)),
                  );
                },
              ),
            ),
            Opacity(
              opacity: 0.75,
              child: Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: BlocBuilder<PagerCubit, int>(
                    builder: (context, state) {
                      return Text(
                        '${state + 1}/${widget.postModel.medias.length}',
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        ListTile(
          title: Text(widget.postModel.caption),
          trailing: IconButton(
            onPressed: () =>
                context.read<PostsCubit>().likePost(widget.postModel.objectId),
            icon: const Icon(Icons.favorite_border),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}