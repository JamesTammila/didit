import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_post.dart';
import 'package:didit/presentation/widget/view_picture_small.dart';

class PostView extends StatelessWidget {
  const PostView({super.key, required this.postModel});

  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: GridView.count(
              primary: false,
              childAspectRatio: 4 / 5,
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              children: <Widget>[
                InkWell(
                  onTap: () => context.pushNamed('Media', extra: postModel.medias[0]),
                  child: Hero(
                    tag: postModel.medias[0].objectId,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 5,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: postModel.medias[0].mediaUri,
                            cacheKey: postModel.medias[0].mediaUri.toString().split('?')[0],
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: SmallPictureView(
                            uri: postModel.medias[0].user.proPicUri,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => context.pushNamed('Media', extra: postModel.medias[1]),
                  child: Hero(
                    tag: postModel.medias[1].objectId,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 5,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: postModel.medias[1].mediaUri,
                            cacheKey: postModel.medias[1].mediaUri.toString().split('?')[0],
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: SmallPictureView(
                            uri: postModel.medias[1].user.proPicUri,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => context.pushNamed('Media', extra: postModel.medias[2]),
                  child: Hero(
                    tag: postModel.medias[2].objectId,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 5,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: postModel.medias[2].mediaUri,
                            cacheKey: postModel.medias[2].mediaUri.toString().split('?')[0],
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: SmallPictureView(
                            uri: postModel.medias[2].user.proPicUri,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => context.pushNamed('Media', extra: postModel.medias[3]),
                  child: Hero(
                    tag: postModel.medias[3].objectId,
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 4 / 5,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: postModel.medias[3].mediaUri,
                            cacheKey: postModel.medias[3].mediaUri.toString().split('?')[0],
                          ),
                        ),
                        Positioned(
                          left: 5,
                          top: 5,
                          child: SmallPictureView(
                            uri: postModel.medias[3].user.proPicUri,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(postModel.theme),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}