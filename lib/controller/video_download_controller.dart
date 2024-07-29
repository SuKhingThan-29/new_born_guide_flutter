import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:chitmaymay/db/dbModel/tbl_content.dart';
import 'package:chitmaymay/service/boxes.dart';
import 'package:chitmaymay/utils/constant_util.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../db/dbModel/tbl_downloaded_video.dart';

class VideoDownloadController extends GetxController {
  List<TblDownloadedVideo> downloadedVideos = [];

  late bool permissionReady;
  final ReceivePort _port = ReceivePort();
  var downloadStatus = DownloadTaskStatus.undefined.obs;
  var downloadProgress = 0.obs;
  var taskId = ''.obs;
  final box = Boxes.getDownloadVideos();
  var currentDownloadId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    init();
    retryRequestPermission();
    bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void onClose() {
    unbindBackgroundIsolate();
    super.onClose();
  }

  late String _localPath;
  Future<bool> getPermission() async {
    if (Platform.isIOS) return true;

    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final result = await Permission.storage.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    } else {
      return true;
    }
    return true;
  }

  Future<bool> retryRequestPermission() async {
    bool hasGranted = await getPermission();

    if (hasGranted) {
      if (Platform.isIOS) {
        // Platform is imported from 'dart:io' package
        final directory = await getApplicationDocumentsDirectory();
        _localPath = directory.path;
      } else if (Platform.isAndroid) {
        final directory = await getApplicationDocumentsDirectory();
        _localPath = '${directory.path}${Platform.pathSeparator}ChitMayMay';
      }

      final savedDir = Directory(_localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
    }

    return hasGranted;
  }

  void cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  void pauseDownload(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  void resumeDownload(String taskId) async {
    await FlutterDownloader.resume(taskId: taskId);
  }

  retryDownload(String taskId) async {
    String? newTaskId = await FlutterDownloader.retry(taskId: taskId);
    return newTaskId ?? "";
  }

  void requestDownload(String link, String fileName, TBLContent content) async {
    final taskId = await FlutterDownloader.enqueue(
      url: link,
      // url:
      //     'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: false,
    );
    final filePath = await ConstantUtils.getFileUrl(fileName);
    TblDownloadedVideo model = TblDownloadedVideo(
        content: content,
        taskId: taskId,
        filename: fileName,
        savedDir: _localPath,
        filePath: filePath);
    box.add(model);
  }

  void bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      print('progres======> $progress');
      if (id == currentDownloadId.value) {
        taskId.value = id;
        downloadStatus.value = status;
        downloadProgress.value = progress;
      }

      updateTask(data);
    });
  }

  updateTask(data) {
    final bool isExist = downloadedVideos.any((obj) => obj.taskId == data[0]);
    if (isExist) {
      for (var val in downloadedVideos) {
        if (val.taskId == data[0]) {
          val.taskId = data[0];
          val.status = data[1];
          val.progress = data[2];
        }
      }
    } else {
      downloadedVideos = box.values.toList();
    }
    update();
  }

  void unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  Future<void> init() async {
    // final tasks = await FlutterDownloader.loadTasks();
    // if (tasks != null) {
    //   for (var val in tasks) {
    //     FlutterDownloader.remove(taskId: val.taskId, shouldDeleteContent: true);
    //   }
    // }
    // box.deleteAll(box.keys);
    downloadedVideos = box.values.toList();
    update();
  }

  initCurrentVideo(title) {
    final bool isExist = downloadedVideos.any((obj) => obj.filename == title);
    if (isExist) {
      for (var val in downloadedVideos) {
        if (val.filename == title) {
          currentDownloadId.value = val.taskId ?? "";
          taskId.value = val.taskId ?? "";
          downloadStatus.value = val.status ?? DownloadTaskStatus.undefined;
          downloadProgress.value = val.progress ?? 0;
        }
      }
    } else {
      currentDownloadId.value = '';
      taskId.value = "";
      downloadStatus.value = DownloadTaskStatus.undefined;
      downloadProgress.value = 0;
    }
  }

  Future<void> deleteVideo(TblDownloadedVideo task, int index) async {
    FlutterDownloader.remove(
        taskId: task.taskId ?? "", shouldDeleteContent: true);
    downloadedVideos.remove(task);
    box.deleteAt(index);
    update();
  }
}
