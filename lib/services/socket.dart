import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{
  ServerStatus _serverStatus = ServerStatus.Connecting;

  ServerStatus get serverStatus => this._serverStatus;

  SocketService(){
    this._initConfig();
  }

  void _initConfig(){
    IO.Socket socket = IO.io('http://192.168.2.156:3000/', {
      'transports': ['websocket'],
      'autoConnect': true
    });

    socket.on('connect', ( _ ) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    // socket.on('nuevo-mensaje', ( payload ) {
    //   print('nuevo-mensaje: $payload');
    // });
  }
}