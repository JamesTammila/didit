import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionsClient {
  Future<void> openSettings();
}

class PermissionsClient implements IPermissionsClient {
  @override
  Future<void> openSettings() async {
    if (!await openAppSettings()) throw "Could not open app settings";
  }
}