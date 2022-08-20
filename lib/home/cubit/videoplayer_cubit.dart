import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'videoplayer_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerState());

  late BetterPlayerController betterPlayerController;

  void setUpVideoPlayer(String videoUrl) {
    
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
    );

    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        autoDispose: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePip: true,
          pipMenuIcon: Icons.picture_in_picture,
          // showControls: false,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    // betterPlayerController.dispose(forceDispose: true);
    emit(VideoPlayerState(betterPlayerController: betterPlayerController, isVisibleMiniPlayer: true));
  }

  Future<void> forceDisposeVideo() async {
    betterPlayerController.dispose(forceDispose: true);
    // betterPlayerController = null;
    emit(VideoPlayerState(betterPlayerController: betterPlayerController, isVideoplaying: false, isVisibleMiniPlayer: false));
  }
  
  Future<void> checkIsVideoPlaying() async {
    bool? isPlaying = betterPlayerController.isPlaying();
    if (isPlaying!) {
      emit(VideoPlayerState(betterPlayerController: betterPlayerController, isVideoplaying: false, isVisibleMiniPlayer: true));
      betterPlayerController.pause();
    } else {
      emit(VideoPlayerState(betterPlayerController: betterPlayerController, isVideoplaying: true, isVisibleMiniPlayer: true));
      betterPlayerController.play();
    }
  }
  
  // Future<void> pauseVideo() async {
  //   var isPlaying;
  //   if (betterPlayerController != null) {
  //     isPlaying = await betterPlayerController.isPlaying();
  //   }
  //   if (isPlaying == true) {
  //     emit(VideoPlayerState(betterPlayerController: betterPlayerController, isVideoplaying: false));
  //     betterPlayerController.pause();
  //   }
  // }

  void enablePictureInPictureMode(GlobalKey<State<StatefulWidget>> key, BuildContext context) async {
    var res = await state.betterPlayerController!.isPictureInPictureSupported();
    if (res) {
      await state.betterPlayerController!.enablePictureInPicture(key);
    } else {
      // CoolAlert.show(
      //   context: context,
      //   type: CoolAlertType.error,
      //   text: 'Sorry your device is not supported PIP mode!',
      // );
    }
  }
}
