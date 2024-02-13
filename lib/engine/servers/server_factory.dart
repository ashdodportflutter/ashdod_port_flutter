import 'package:ashdod_port_flutter/engine/servers/firebase_handler.dart';
import 'package:ashdod_port_flutter/engine/servers/server.dart';
import 'package:ashdod_port_flutter/engine/servers/server_simulation.dart';

enum ServerType {
  firebase, testServer
}

class ServerFactory {
  static Server createServer(ServerType type) {
    switch (type) {

      case ServerType.firebase:
        return FirebaseHandler();
      case ServerType.testServer:
        return ServerSimulation();
    }
  }
}