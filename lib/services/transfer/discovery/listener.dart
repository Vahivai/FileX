import 'dart:io';

class DiscoveryListener {
  RawDatagramSocket? _socket;

  Future<void> startListening() async {
    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      8888,
    );

    print("🎧 Listening on port 8888");

    _socket!.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = _socket!.receive();

        if (datagram != null) {
          final message = String.fromCharCodes(datagram.data);

          print("Received: $message");
        }
      }
    });
  }

  void stop() {
    _socket?.close();
  }
}