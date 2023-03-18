import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:didit/util/manager_cache.dart';
import 'package:didit/model/model_match.dart';
import 'package:didit/feature/home/bloc/cubit_match.dart';
import 'package:didit/feature/home/bloc/cubit_pager.dart';
import 'package:didit/feature/home/widget/view_picture_medium.dart';
import 'package:didit/feature/home/widget/view_picture_small.dart';

class FinishedMatchView extends StatefulWidget {
  const FinishedMatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  FinishedMatchViewState createState() => FinishedMatchViewState();
}

class FinishedMatchViewState extends State<FinishedMatchView> {
  final PageController controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          ListTile(
            leading: ListView.builder(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: widget.matchModel.medias.length,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => context.pushNamed('user',
                      extra: widget.matchModel.medias[i].user),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: BlocBuilder<PagerCubit, int>(
                      builder: (context, state) {
                        if (state == i) {
                          return MediumPictureView(
                            userModel: widget.matchModel.medias[i].user,
                          );
                        } else {
                          return SmallPictureView(
                            userModel: widget.matchModel.medias[i].user,
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
                return Text(widget.matchModel.medias[state].user.username);
              },
            ),
            trailing: PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  onTap: () => {},
                  child: const Text('View Likes'),
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
                  itemCount: widget.matchModel.medias.length,
                  onPageChanged: (i) => context.read<PagerCubit>().swipePage(i),
                  itemBuilder: (context, i) {
                    return CachedNetworkImage(
                      cacheManager: context.read<CustomCacheManager>(),
                      fit: BoxFit.cover,
                      imageUrl: widget.matchModel.medias[i].getUrl,
                      cacheKey: widget.matchModel.medias[i].getUrl.split('?')[0],
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
                          '${state + 1}/${widget.matchModel.medias.length}',
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
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.matchModel.caption),
                const SizedBox(height: 5),
                Opacity(
                  opacity: 0.75,
                  child: Text(
                    timeago.format(DateTime.parse(widget.matchModel.createdAt)),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            trailing: IconButton(
              onPressed: () => {},
              icon: const Icon(Icons.favorite_border),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.read<MatchCubit>().deletePost(),
                child: const Text(
                  'Delete Post',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}