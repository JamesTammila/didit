import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:didit/domain/model/model_match.dart';
import 'package:didit/presentation/widget/view_user.dart';

class MatchView extends StatelessWidget {
  const MatchView({super.key, required this.matchModel});

  final MatchModel matchModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text(matchModel.theme)),
        const SizedBox(height: 10),
        Stack(
          children: [
            Card(
              child: InteractiveViewer(
                panEnabled: false,
                child: AspectRatio(
                  aspectRatio: 4 / 5,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: matchModel.posts[0].mediaUri,
                    cacheKey:
                        matchModel.posts[0].mediaUri.toString().split('?')[0],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 5,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserView(userModel: matchModel.posts[0].user),
                  const SizedBox(width: 5),
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert),
                    itemBuilder: (context) => <PopupMenuEntry>[
                      const PopupMenuItem(child: Text('Report Post')),
                      const PopupMenuItem(child: Text('Block User')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}