// ignore: library_prefixes
import 'dart:async';

import 'package:cuidame/app/utils/utils.dart';
import 'package:cuidame/app/utils/utils_logger.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketIOClient {
  IO.Socket socket = IO.io('https://${Utils.apiUrlBase}', {
    'autoConnect': true,
    'transports': ['websocket']
  });

  final _socketConnectedStream = StreamController<bool>();

  SocketIOClient() {
    _initSocket();
  }

  Stream get socketConnected => _socketConnectedStream.stream;

  _initSocket() {
    socket.onConnect((_) {
      UtilsLogger().i('Connected Socket IO');
      _socketConnectedStream.add(true);
    });
    socket.onDisconnect((data) => UtilsLogger().w(data));
    socket.onError((err) => UtilsLogger().e(err));
  }
}
