part of 'videoplayer_cubit.dart';

class VideoPlayerState {
  BetterPlayerController? betterPlayerController;
  bool isVideoplaying;
  bool isVisibleMiniPlayer;
  
  VideoPlayerState({
    this.betterPlayerController,
    this.isVideoplaying = true,
    this.isVisibleMiniPlayer = false,
  });
}
