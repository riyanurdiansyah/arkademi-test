import 'package:flutter/material.dart';
import 'package:test_arkademi/provider/home_provider.dart';
import 'package:video_player/video_player.dart';

class HomeVideo extends StatelessWidget {
  const HomeVideo({
    Key? key,
    required HomeProvider provider,
  })  : _provider = provider,
        super(key: key);

  final HomeProvider _provider;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      background: _provider.selectedVideo == ""
          ? const SizedBox()
          : _provider.videoController.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _provider.videoController.value.aspectRatio,
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () => _provider.startPauseVideo(),
                        child: VideoPlayer(
                          _provider.videoController,
                        ),
                      ),
                      _provider.videoController.value.isPlaying
                          ? const SizedBox()
                          : Container(
                              alignment: Alignment.center,
                              color: Colors.black26,
                              child: InkWell(
                                onTap: () => _provider.startPauseVideo(),
                                child: const Icon(
                                  Icons.play_arrow_rounded,
                                  color: Colors.white,
                                  size: 80,
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          height: 12,
                          child: VideoProgressIndicator(
                            _provider.videoController,
                            allowScrubbing: true,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
    );
  }
}
