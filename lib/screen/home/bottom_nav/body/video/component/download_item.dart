import 'package:chitmaymay/common/com_widget.dart';
import 'package:chitmaymay/controller/video_download_controller.dart';
import 'package:chitmaymay/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DownloadItem extends StatefulWidget {
  DownloadItem({
    Key? key,
    this.data,
    this.onTap,
    this.onActionTap,
    this.onCancel,
    required this.isDownloadDelete,
  }) : super(key: key);

  final ItemHolder? data;
  final Function(TaskInfo?)? onTap;
  final Function(TaskInfo)? onActionTap;
  final Function(TaskInfo)? onCancel;
  bool isDownloadDelete;

  @override
  DownloadItemState createState() => DownloadItemState();
}

class DownloadItemState extends State<DownloadItem> {
  final VideoDownloadController _videoController =
      Get.put(VideoDownloadController());
  late ComWidgets comWidgets = ComWidgets();
  String? status;
  @override
  void initState() {
    super.initState();
    _videoController.onInit();
    print('Widget isDownloadDeleted: ${widget.isDownloadDelete}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget? buildTrailing(TaskInfo? taskInfo) {
    print('Task Status begin: ${taskInfo!.status}');
    if (taskInfo.status == DownloadTaskStatus.undefined) {
      return IconButton(
        onPressed: () {
          //_videoController.saveVideoData(widget.data!, taskInfo.progress);
          widget.onActionTap?.call(taskInfo);
        },
        constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
        icon: SvgPicture.asset('assets/video_icon/download.svg'),
      );
    } else if (taskInfo.status == DownloadTaskStatus.running) {
      return Row(
        children: [
          Text(
            '${taskInfo.progress}%',
            style: const TextStyle(color: Colors.black),
          ),
          IconButton(
            onPressed: () => widget.onActionTap?.call(taskInfo),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: SvgPicture.asset('assets/video_icon/pause.svg'),
          ),
        ],
      );
    } else if (taskInfo.status == DownloadTaskStatus.paused) {
      return Row(
        children: [
          Text('${taskInfo.progress}%'),
          IconButton(
            onPressed: () => widget.onActionTap?.call(taskInfo),
            // constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.play_arrow, color: Colors.deepPurple),
          ),
          IconButton(
            onPressed: () => widget.onActionTap?.call(taskInfo),
            // constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(
              Icons.cancel,
              color: Colors.deepPurple,
            ),
          ),
        ],
      );
    } else if (
        taskInfo.status == DownloadTaskStatus.complete) {
      return IconButton(
        onPressed: () {},
        constraints: const BoxConstraints(minHeight: 20, minWidth: 20),
        icon: SvgPicture.asset('assets/video_icon/done.svg'),
      );
    } else if (taskInfo.status == DownloadTaskStatus.canceled) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Canceled', style: TextStyle(color: Colors.red)),
          IconButton(
            onPressed: () => widget.onActionTap?.call(taskInfo),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(
              Icons.cancel,
              color: Colors.deepPurple,
            ),
          )
        ],
      );
    } else if (taskInfo.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Failed', style: TextStyle(color: Colors.red)),
          IconButton(
            onPressed: () => widget.onActionTap?.call(taskInfo),
            //constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(Icons.refresh, color: Colors.deepPurple),
          )
        ],
      );
    } else if (taskInfo.status == DownloadTaskStatus.enqueued) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Pending', style: TextStyle(color: Colors.orange)),
          IconButton(
            onPressed: () => widget.onActionTap?.call(taskInfo),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 32),
            icon: const Icon(
              Icons.cancel,
              color: Colors.deepPurple,
            ),
          )
        ],
      );
      //return const Text('Pending', style: TextStyle(color: Colors.orange));
    } else {
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    try {
        if (widget.data!.task!.status == DownloadTaskStatus.complete) {
          status = "Downloaded";
        } else if (widget.data!.task!.status == DownloadTaskStatus.running) {
          status = "Downloading";
        } else {
          status = "Download";
        }

    } catch (e) {
      status = "Download";
      setState(() {});
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            status!,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: widget.data != null
              ? buildTrailing(widget.data!.task!)
              // ?Text('${widget.data!.task!.contentId} : $isDownloadDelete')
              : Container(),
        ),
      ],
    );
    // return  Text(widget.content.url);
  }
}
