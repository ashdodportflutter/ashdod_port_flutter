import 'package:ashdod_port_flutter/engine/servers/extensions.dart';
import 'package:ashdod_port_flutter/engine/servers/server.dart';

class ServerSimulation implements Server {
  @override
  Future<Result<String>> login({required String email, required String password}) {
    return Future.value(Result.error(failure: 'this is a test'.error));
  }

  @override
  Future<Result<bool>> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Result> fetchData<T>({required Request<T> request}) {
    // TODO: implement fetchData
    throw UnimplementedError();
  }



}
