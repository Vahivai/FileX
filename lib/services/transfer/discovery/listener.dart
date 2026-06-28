import 'dart:io';

import '../utils/constants.dart';

class DiscoveryListener {
  final void Function(String message, InternetAddress address)? onMessage;

  DiscoveryListener({this.onMessage});

  RawDatagramSocket? _socket;

  Future<void> startListening() async {
    _socket = await RawDatagramSocket.bind(
      InternetAddress.anyIPv4,
      TransferConstants.discoveryPort,
    );

    print("🎧 Listening on port ${TransferConstants.discoveryPort}");

    _socket!.listen((event) {
      if (event == RawSocketEvent.read) {
        final datagram = _socket!.receive();

        if (datagram != null) {
          final message = String.fromCharCodes(datagram.data);

          print("Received: $message");

          onMessage?.call(
            message,
            datagram.address,
          );
        }
      }
    });
  }

  void stop() {
    _socket?.close();
  }
}