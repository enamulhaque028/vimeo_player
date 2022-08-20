import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:vimeo_player/home/cubit/videoplayer_cubit.dart';
import 'package:vimeo_player/home/view/details_page.dart';

class MiniPlayerWidget extends StatelessWidget {
  final MiniplayerController miniplayerController;
  final double miniplayerHeight;
  final VoidCallback onTapCancel;

  const MiniPlayerWidget({
    Key? key,
    required this.miniplayerController,
    required this.miniplayerHeight,
    required this.onTapCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
      builder: (context, state) {
        return !state.isVisibleMiniPlayer
          ? const SizedBox()
          : Miniplayer(
              controller: miniplayerController,
              minHeight: miniplayerHeight,
              maxHeight: MediaQuery.of(context).size.height,
              builder: (height, percentage) {
                if (height <= miniplayerHeight + 50.0) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: miniplayerHeight,
                            width: 120.0,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: BetterPlayer(controller: state.betterPlayerController!,
                                // key: navigatorKey,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Flexible(
                                    child: Text(
                                      'video title',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      'selectedVideo author username',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            icon: state.isVideoplaying
                                ? const Icon(Icons.pause)
                                : const Icon(Icons.play_arrow),
                            onPressed: () {
                              BlocProvider.of<VideoPlayerCubit>(context).checkIsVideoPlaying();
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              onTapCancel();
                              BlocProvider.of<VideoPlayerCubit>(context).forceDisposeVideo();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const DetailsPage();
              },
            );
      },
    );
  }
}
