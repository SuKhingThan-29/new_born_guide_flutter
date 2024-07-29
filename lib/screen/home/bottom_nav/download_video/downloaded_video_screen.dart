import 'package:chitmaymay/controller/video_download_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_downloaded_video.dart';
import 'package:chitmaymay/screen/home/bottom_nav/download_video/component/downloaded_video_item.dart';
import 'package:chitmaymay/screen/home/bottom_nav/download_video/play_download_video_screen.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants.dart';

class DownloadedVideoScreen extends StatefulWidget {
  const DownloadedVideoScreen({Key? key}) : super(key: key);

  @override
  State<DownloadedVideoScreen> createState() => _DownloadedVideoScreenState();
}

class _DownloadedVideoScreenState extends State<DownloadedVideoScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: backgroundColor,
          elevation: 0,
          title: CustomText(
            text: 'Download List'.tr,
            textStyle: kTextStyleBoldBlack(14),
          ),
        ),
        body: GetBuilder<VideoDownloadController>(
            init: VideoDownloadController(),
            builder: (value) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.downloadedVideos.length,
                  itemBuilder: (context, index) {
                    final TblDownloadedVideo task =
                        value.downloadedVideos[index];
                    return GestureDetector(
                        onTap: () async {
                          Get.to(() =>
                              PlayDownloadVideo(filePath: task.filePath ?? ''));
                        },
                        child: DownloadedVideoItem(
                          task: task,
                          onDelete: (taskId) {
                            value.deleteVideo(task, index);
                          },
                        ));
                  });
            }));
  }
}
