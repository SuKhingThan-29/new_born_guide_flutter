import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitmaymay/utils/constants.dart';
import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import '../../../../../db/dbModel/tbl_downloaded_video.dart';
import '../../../../../utils/widgets/custom_text.dart';

class DownloadedVideoItem extends StatefulWidget {
  final TblDownloadedVideo task;
  final Function(String) onDelete;
  const DownloadedVideoItem(
      {Key? key, required this.task, required this.onDelete})
      : super(key: key);

  @override
  State<DownloadedVideoItem> createState() => _DownloadedVideoItemState();
}

class _DownloadedVideoItemState extends State<DownloadedVideoItem> {
  bool isDelete = false;

  @override
  Widget build(BuildContext context) {
    var progress = widget.task.progress ?? 0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 7,
              child: CachedNetworkImage(
                imageUrl: widget.task.content?.imageUrl ?? "",
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    maxLines: 2,
                    text: widget.task.content?.title ?? '',
                    textStyle: kTextStyleBoldBlack(14),
                  ),
                  kVerticalSpace(4),
                  CustomText(
                    text: widget.task.content?.mp4Size ?? '',
                    textStyle: kTextStyleBlack(12),
                  ),
                  kVerticalSpace(4),
                  (widget.task.status == DownloadTaskStatus.complete ||
                          progress == 100)
                      ? CustomText(
                          text: 'Completed',
                          textStyle: kTextStyleBlack(12),
                        )
                      : Row(
                          children: <Widget>[
                            Text('$progress%'),
                            kVerticalSpace(4),
                            Expanded(
                              child: LinearProgressIndicator(
                                value: progress / 100,
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    isDelete = !isDelete;
                  });
                },
                icon: const Icon(Icons.more_vert_outlined))
          ],
        ),
        isDelete
            ? GestureDetector(
                onTap: () {
                  widget.onDelete(widget.task.taskId ?? '');
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: backgroundDarkPurple),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                      child: CustomText(
                    text: 'Delete'.tr,
                    textStyle: kTextStyleBlack(14),
                  )),
                ),
              )
            : Container(),
        kDivider(),
      ],
    );
  }
}
