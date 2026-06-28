import 'dart:convert';
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

    _socket!.listen((event) async {
      if (event != RawSocketEvent.read) return;

      final datagram = _socket!.receive();

      if (datagram == null) return;

      final message = utf8.decode(datagram.data);

      print("Received: $message");

      onMessage?.call(message, datagram.address);

      // Someone is searching for devices
      if (message.startsWith(TransferConstants.discoveryPrefix)) {
        final response =
            "${TransferConstants.responsePrefix}|${Platform.localHostname}";

        _socket!.send(
          utf8.encode(response),
          datagram.address,
          TransferConstants.discoveryPort,
        );
      }
    });
  }

  void stop() {
    _socket?.close();
  }
}