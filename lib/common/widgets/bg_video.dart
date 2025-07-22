import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:video_player/video_player.dart';

class BackgroundVideo extends StatefulWidget {
  const BackgroundVideo({super.key});

  @override
  State<BackgroundVideo> createState() => _BackgroundVideoState();
}

class _BackgroundVideoState extends State<BackgroundVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = kIsWeb
        ? VideoPlayerController.asset('assets/videos/bg.webm')
        : VideoPlayerController.asset('assets/videos/bg.mp4');

    _controller.initialize().then((_) {
      _controller.setLooping(true);
      _controller.setVolume(0);
      _controller.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? SizedBox.expand(
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    AppColors1.background.withValues(alpha: 0.05),
                    BlendMode.screen,
                  ),
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          )
        : const SizedBox.expand();
  }
}
