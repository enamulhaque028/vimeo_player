import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:vimeo_player/home/cubit/videoplayer_cubit.dart';
import 'package:vimeo_player/widgets/miniplayer_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MiniplayerController controller = MiniplayerController();
  final double _playerMinHeight = 70;
  int miliseconds = 200;

  @override
  Widget build(BuildContext context) {
    return MiniplayerWillPopScope(
      onWillPop: () async {
        // final NavigatorState navigator = navigatorKey.currentState;
        if (!Navigator.of(context).canPop()) return true;
        Navigator.of(context).pop();
        return false;
      },
      child: Stack(
        children: [
          BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
            builder: (context, state) {
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (state.isVisibleMiniPlayer) {
                      BlocProvider.of<VideoPlayerCubit>(context)
                          .forceDisposeVideo();
                    }
                    BlocProvider.of<VideoPlayerCubit>(context).setUpVideoPlayer(
                        "https://25vod-adaptive.akamaized.net/exp=1661023891~acl=%2F35bb78b0-5e94-4869-80eb-9e6a7e877888%2F%2A~hmac=e62c048594245d9a26006f1a7e3754e0e8cfd8662d9c2426a2dedff021adfa54/35bb78b0-5e94-4869-80eb-9e6a7e877888/sep/video/fde1f9d2,af3de0c6,b229a868/audio/e59359f9,b2dfd67f/master.m3u8?query_string_ranges=1"
                        // "http://aosoptv.com/aostv/bs/Q2hhbm5lbCBJ/aHR0cHM6Ly9lZGdlNC5iaW9zY29wZWxpdmUuY29tL2hscw==/Y2hhbm5lbF9p/aos.m3u8|User-Agent:B Player|Auth:_"
                        );
                    Future.delayed(Duration(milliseconds: miliseconds), () {
                      controller.animateToHeight(state: PanelState.MAX);
                      miliseconds = 50;
                    });
                  },
                  child: const Text('play'),
                ),
              );
            },
          ),
          Stack(
            children: [
              Positioned(
                // bottom: 40,
                child: MiniPlayerWidget(
                  miniplayerController: controller,
                  miniplayerHeight: _playerMinHeight,
                  onTapCancel: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
