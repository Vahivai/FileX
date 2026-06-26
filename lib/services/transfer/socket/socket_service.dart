import 'dart:io';

class SocketService {
  Socket? socket;

  Future<void> connect(String ip, int port) async {
    socket = await Socket.connect(ip, port);
  }

  Future<void> disconnect() async {
    await socket?.close();
  }
}