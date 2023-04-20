import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/feature/home/bloc/cubit_item_post.dart';
import 'package:didit/feature/home/widget/view_picture_small.dart';
import 'package:didit/feature/home/widget/view_picture_medium.dart';
import 'package:didit/feature/home/widget/sheet_post.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.postModel});

  final PostModel postModel;

  @override
  PostItemState createState() => PostItemState();
}

class PostItemState extends State<PostItem> {
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
          minVerticalPadding: 15,
          title: Text(
            widget.postModel.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              AspectRatio(
                aspectRatio: 4 / 5,
                child: PageView.builder(
                  allowImplicitScrolling: true,
                  controller: controller,
                  itemCount: widget.postModel.medias.length,
                  onPageChanged: (i) => context.read<PagerCubit>().swipePage(i),
                  itemBuilder: (context, i) {
                    return CachedNetworkImage(
                      cacheManager: context.read<CustomCacheManager>(),
                      fit: BoxFit.cover,
                      imageUrl: widget.postModel.medias[i].getUrl,
                      cacheKey: widget.postModel.medias[i].getUrl.split('?')[0],
                      progressIndicatorBuilder: (context, url, progress) => Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          value: progress.progress,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Center(child: Text('Something went wrong...')),
                    );
                  },
                ),
              ),
              /*Opacity(
                opacity: 0.75,
                child: Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: BlocBuilder<PagerCubit, int>(
                      builder: (context, state) {
                        return Text(
                          '${state + 1}/${widget.postModel.medias.length}',
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      },
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 45,
          child: ListView.builder(
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
                          userModel: widget.postModel.medias[i].user,
                        );
                      } else {
                        return SmallPictureView(
                          userModel: widget.postModel.medias[i].user,
                        );
                      }
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          width: 60,
          child: IconButton(
            onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) => BlocProvider<PostItemCubit>(
                create: (context) => PostItemCubit(
                  context.read<PostRepository>(),
                ),
                child: PostSheet(postModel: widget.postModel),
              ),
            ),
            icon: const Icon(Icons.more_horiz),
          ),
        ),
      ],
    );
  }
}