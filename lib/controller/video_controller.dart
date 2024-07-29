import 'package:better_player/better_player.dart';
import 'package:chitmaymay/db/dbModel/tbl_downloaded_video.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

import '../service/boxes.dart';

class VideoController extends GetxController {
  late BetterPlayerController betterPlayerController;
  var videoLoading = true.obs;
  var filePath = ''.obs;
  final box = Boxes.getDownloadVideos();

  BetterPlayerControlsConfiguration controlsConfiguration =
      const BetterPlayerControlsConfiguration(
    controlBarColor: Colors.black26,
    iconsColor: Colors.white,
    playIcon: Icons.play_arrow_outlined,
    progressBarPlayedColor: whiteColor,
    progressBarHandleColor: whiteColor,
    skipBackIcon: Icons.replay_10_outlined,
    skipForwardIcon: Icons.forward_10_outlined,
    backwardSkipTimeInMilliseconds: 10000,
    forwardSkipTimeInMilliseconds: 10000,
    enableSkips: true,
    enableFullscreen: true,
    enablePip: true,
    enablePlayPause: true,
    enableMute: true,
    enableAudioTracks: true,
    enableProgressText: true,
    enableSubtitles: true,
    showControlsOnInitialize: true,
    enablePlaybackSpeed: true,
    controlBarHeight: 40,
    loadingColor: whiteColor,
    overflowModalColor: Colors.black54,
    overflowModalTextColor: Colors.white,
    overflowMenuIconsColor: Colors.white,
  );

  void initPlayer(String videoUrl, String fileName) async {
    filePath.value = '';
    List<TblDownloadedVideo> downloadedVideos = box.values.toList();
    for (var val in downloadedVideos) {
      if (val.filename == fileName) {
        if (val.status == DownloadTaskStatus.complete) {
          filePath.value = val.filePath ?? "";
        }
      }
    }

    BetterPlayerConfiguration betterPlayerConfiguration =
        BetterPlayerConfiguration(
            autoPlay: true,
            controlsConfiguration: controlsConfiguration,
            aspectRatio: 16 / 9,
            fit: BoxFit.contain,
            autoDetectFullscreenAspectRatio: true,
            autoDetectFullscreenDeviceOrientation: true,
            subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
              fontSize: 16.0,
            ));

    BetterPlayerDataSource? betterPlayerDataSource;
    if (filePath.value != '') {
      betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.file,
        filePath.value,
      );
    } else {
      betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        videoUrl,
        cacheConfiguration: BetterPlayerCacheConfiguration(
          useCache: true,
          preCacheSize: 10 * 1024 * 1024,
          maxCacheSize: 10 * 1024 * 1024,
          maxCacheFileSize: 10 * 1024 * 1024,
          key: videoUrl,
        ),
      );
    }
    betterPlayerController = BetterPlayerController(betterPlayerConfiguration,
        betterPlayerDataSource: betterPlayerDataSource);

    videoLoading.value = false;
  }

  disposeController() {
    betterPlayerController.dispose();
  }

  @override
  void onClose() {
    betterPlayerController.dispose();
    super.onClose();
  }
}
