import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:didit/model/model_post.dart';
import 'package:didit/util/manager_cache.dart';
import 'package:didit/util/formatter_month.dart';
import 'package:didit/feature/account/bloc/cubit_memories_page.dart';
import 'package:didit/feature/account/bloc/cubit_pager.dart';
import 'package:didit/feature/account/widget/dialog_delete_post.dart';
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
    final MemoriesPageCubit bloc = context.read<MemoriesPageCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        Text(
          '${DateTime.parse(widget.postModel.createdAt).day} '
          '${formatMonth(DateTime.parse(widget.postModel.createdAt).month)} '
          '${DateTime.parse(widget.postModel.createdAt).year}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
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
          title: BlocBuilder<PagerCubit, int>(
            builder: (context, state) {
              return Text(
                widget.postModel.medias[state].user.username,
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
          trailing: PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String choice) {
              if (choice == 'Report Post') {}
              if (choice == 'Delete Post') {
                showDialog(
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: bloc,
                    child: DeletePostDialog(
                      memory: widget.postModel,
                    ),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'Report Post',
                child: Text('Report Post'),
              ),
              const PopupMenuItem<String>(
                value: 'Delete Post',
                child: Text('Delete Post', style: TextStyle(color: Colors.red)),
              ),
            ],
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
                        style: Theme.of(context).textTheme.bodySmall,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        ListTile(
          minVerticalPadding: 15,
          title: Text(
            widget.postModel.caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Text(
              timeago.format(
                DateTime.parse(widget.postModel.createdAt),
                locale: 'en_short',
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}