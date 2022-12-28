import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

enum ServerStatus { online, offline, connecting }

class SocketService extends ChangeNotifier {
  List messages = [];
  String by = "Esperando Usuario...";
  ServerStatus _serverStatus = ServerStatus.connecting;
  late io.Socket _socket;

  ServerStatus get serverStatus => _serverStatus;

  io.Socket get socket => _socket;
  // Function get emit => _socket.emit;

  SocketService() {
    _initConfig();
    getMessages();
  }

  void _initConfig() {
    // Dart client
    _socket = io.io('http://192.168.0.101:8080', {
      'transports': ['websocket'],
      'autoConnect': true,
      "forceNew": true,
    });
    _socket.onConnecting((_) {
      _serverStatus = ServerStatus.connecting;
      notifyListeners();
    });

    _socket.onConnect((_) {
      _serverStatus = ServerStatus.online;
      notifyListeners();
    });

    _socket.onDisconnect((_) {
      _serverStatus = ServerStatus.offline;
      notifyListeners();
    });
  }

  getMessages() async {
    final audioPlayer = AudioPlayer();
    _socket.on("recibir-mensaje", (payload) {
      audioPlayer.play(AssetSource("sounds/sonido.mp3"));
      by = payload["by"];
      messages.add(payload);
      notifyListeners();
    });
  }

  sendMessage({
    required String message,
  }) {
    final messageSended = {
      "message": message,
      "by": "Jesus Reyes",
      "createdAt": DateTime.now().toUtc().toString()
    };

    _socket.emit("send-message", messageSended);
    messages.add(messageSended);
    notifyListeners();
  }
}
