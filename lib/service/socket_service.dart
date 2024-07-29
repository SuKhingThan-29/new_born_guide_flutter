import 'package:chitmaymay/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;

  SocketService._() {
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'reconnection': true,
      'reconnectionDelay': 800,
      'auth': {'token': tokenValue}
    });

    socket.connect();

    socket.onConnect((data) {
      debugPrint("socket====>Socket response chitmaymay: ${socket.connected}");
    });
  }

  void onClose() {
    socket.dispose();
    socket.destroy();
    socket.close();
    socket.disconnect();
  }
}

SocketService socketService = SocketService._();
