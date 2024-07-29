import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DwonloadService {
  late bool permissionReady;
  late String _localPath;
  final ReceivePort _port = ReceivePort();
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
      final directory = await getApplicationDocumentsDirectory();
      _localPath = '${directory.path}/ChitMayMay';
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

  void requestDownload(String link,String fileName) async {
    await FlutterDownloader.enqueue(
      url: link,
      headers: {"auth": "test_for_sql_encoding"},
      savedDir: _localPath,
      fileName: fileName,
      showNotification: true,
      openFileFromNotification: false,
    );
  }

  List bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    DownloadTaskStatus? status;
    int? progress;
    if (!isSuccess) {
      unbindBackgroundIsolate();
      bindBackgroundIsolate();
      return [];
    }
    _port.listen((dynamic data) {
      // String? id = data[0];
      status = data[1];
      progress = data[2];
    });
    return [status, progress];
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
}

