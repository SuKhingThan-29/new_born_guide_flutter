import 'package:chitmaymay/controller/video_download_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class DownloadProcessButton extends StatefulWidget {
  final TBLContent content;
  final String filePath;
  const DownloadProcessButton(
      {Key? key, required this.content, required this.filePath})
      : super(key: key);

  @override
  State<DownloadProcessButton> createState() => _DownloadProcessButtonState();
}

class _DownloadProcessButtonState extends State<DownloadProcessButton> {
  final VideoDownloadController _controller =
      Get.find<VideoDownloadController>();

  @override
  Widget build(BuildContext context) {
    _controller.initCurrentVideo(widget.content.title);
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (widget.filePath != '') {
            return;
          }
          if (_controller.downloadStatus.value == DownloadTaskStatus.running) {
            _controller.cancelDownload(_controller.taskId.value);
          } else if (_controller.downloadStatus.value ==
              DownloadTaskStatus.undefined) {
            _controller.requestDownload(widget.content.urlMp4 ?? '',
                widget.content.title ?? 'ChitMayMay', widget.content);
          } else if (_controller.downloadStatus.value ==
              DownloadTaskStatus.failed) {
            _controller.requestDownload(widget.content.urlMp4 ?? '',
                widget.content.title ?? 'ChitMayMay', widget.content);
          } else if (_controller.downloadStatus.value ==
              DownloadTaskStatus.canceled) {
            _controller.requestDownload(widget.content.urlMp4 ?? '',
                widget.content.title ?? 'ChitMayMay', widget.content);
          }
        },
        child: Container(
            height: 40,
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            decoration: BoxDecoration(
                border: Border.all(color: backgroundDarkPurple),
                borderRadius: BorderRadius.circular(25),
                color: Colors.white),
            child: iconWidget()),
      );
    });
  }

  Widget iconWidget() {
    if (_controller.downloadStatus.value == DownloadTaskStatus.running) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: CustomText(
              text: 'Cancel',
              textStyle: kTextStyleBlack(12),
            ),
          ),
          kHorizontalSpace(8),
          Text(
            "${_controller.downloadProgress.value}%",
            style: const TextStyle(
                fontSize: 12.0, color: backgroundDarkPurple, height: 0.8),
          )
        ],
      );
    } else if (_controller.downloadStatus.value ==
        DownloadTaskStatus.complete) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: CustomText(
              text: 'Downloaded',
              textStyle: kTextStyleBlack(12),
            ),
          ),
          kHorizontalSpace(8),
          const Icon(
            Icons.check_circle,
            color: backgroundDarkPurple,
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: CustomText(
            text: 'Download',
            textStyle: kTextStyleBlack(12),
          ),
        ),
        kHorizontalSpace(8),
        const Icon(
          Icons.download,
          color: backgroundDarkPurple,
        )
      ],
    );
  }
}
