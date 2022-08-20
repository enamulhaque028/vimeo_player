import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimeo_player/home/cubit/videoplayer_cubit.dart';
import 'package:vimeo_player/main.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
              builder: (context, state) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: BetterPlayer(
                    controller: state.betterPlayerController!,
                    // key: navigatorKey,
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () async {
                BlocProvider.of<VideoPlayerCubit>(context).enablePictureInPictureMode(navigatorKey, context);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.picture_in_picture_alt, color: Colors.white),
              ),
            ),
          ],
        ),
        Flexible(
          flex: 10,
          child: SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Link ${index+1} |',
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: VerticalDivider(thickness: 1, color: Colors.white),
                    )
                  ],
                );
              }),
          ),
        ),
      ],
    );
  }
}
