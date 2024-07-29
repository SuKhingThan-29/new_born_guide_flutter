import 'package:better_player/better_player.dart';
import 'package:chitmaymay/controller/body_controller.dart';
import 'package:chitmaymay/controller/video_controller.dart';
import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/screen/home/bottom_nav/body/video/download_process_button.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:chitmaymay/utils/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../component/title_love_share_save.dart';
import 'component/related_video_card_wiget.dart';

class VideoDetailScreen extends StatefulWidget {
  final TBLContent content;
  final BodyController bodyController;
  const VideoDetailScreen(
      {Key? key, required this.content, required this.bodyController})
      : super(key: key);

  @override
  State<VideoDetailScreen> createState() => _VideoDetailScreenState();
}

class _VideoDetailScreenState extends State<VideoDetailScreen> {
  final VideoController _controller = Get.put(VideoController());

  @override
  void initState() {
    _controller.initPlayer(
        widget.content.url ?? '', widget.content.title ?? '');
    widget.bodyController.fetchContentDetail(widget.content.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: backgroundColor,
        body: Column(mainAxisSize: MainAxisSize.min, children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: _controller.videoLoading.value
                ? const CustomLoading()
                : Stack(
                    children: [
                      BetterPlayer(
                        controller: _controller.betterPlayerController,
                      ),
                      Positioned(
                        top: 20,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: whiteColor,
                            )),
                      )
                    ],
                  ),
          ),
          Container(
              color: whiteColor,
              child: TitleLoveShareSave(content: widget.content)),
          (widget.content.urlMp4!.isNotEmpty)
              ? Container(
                  color: whiteColor,
                  child: DownloadProcessButton(
                    content: widget.content,
                    filePath: _controller.filePath.value,
                  ))
              : Container(),
          Expanded(
              child: widget.bodyController.loadingConentDetail.value
                  ? const CustomLoading()
                  : MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                          itemCount:
                              widget.bodyController.relatedContent.length,
                          itemBuilder: (context, cIndex) {
                            if (widget
                                .bodyController.relatedContent.isNotEmpty) {
                              var relatedContent =
                                  widget.bodyController.relatedContent[cIndex];
                              return GestureDetector(
                                onTap: () async {
                                  _controller.disposeController();
                                  Get.off(
                                      () => VideoDetailScreen(
                                            content: relatedContent,
                                            bodyController:
                                                widget.bodyController,
                                          ),
                                      preventDuplicates: false);
                                },
                                child: RelatedVideoCardWiget(
                                  type: "video",
                                  content: relatedContent,
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    ))
        ]),
      );
    });
  }
}
