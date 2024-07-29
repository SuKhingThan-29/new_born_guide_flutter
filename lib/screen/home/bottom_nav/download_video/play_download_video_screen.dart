import 'package:better_player/better_player.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayDownloadVideo extends StatelessWidget {
  final String filePath;
  const PlayDownloadVideo({Key? key, required this.filePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blackColor,
        appBar: AppBar(
          backgroundColor: blackColor,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: whiteColor,
              )),
        ),
        body: Center(child: BetterPlayer.file(filePath)));
  }
}
