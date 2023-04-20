import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/model/model_post.dart';
import 'package:didit/repo/repo_posts.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/util/formatter_date.dart';
import 'package:didit/feature/account/bloc/cubit_pager.dart';
import 'package:didit/feature/account/bloc/cubit_item_memory.dart';
import 'package:didit/feature/account/widget/sheet_memory.dart';
import 'package:didit/feature/home/widget/view_picture_small.dart';
import 'package:didit/feature/home/widget/view_picture_medium.dart';

class MemoryItem extends StatefulWidget {
  const MemoryItem({super.key, required this.postModel});

  final PostModel postModel;

  @override
  MemoryItemState createState() => MemoryItemState();
}

class MemoryItemState extends State<MemoryItem> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          formatDate(widget.postModel.createdAt),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
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
          child: AspectRatio(
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
              backgroundColor: Colors.transparent,
              elevation: 0,
              context: context,
              builder: (context) => BlocProvider<MemoryItemCubit>(
                create: (context) => MemoryItemCubit(
                  context.read<PostRepository>(),
                ),
                child: MemorySheet(postModel: widget.postModel),
              ),
            ),
            icon: const Icon(Icons.more_horiz),
          ),
        ),
      ],
    );
  }
}