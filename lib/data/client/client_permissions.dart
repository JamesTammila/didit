import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionsClient {
  Future<void> openSettings();
  Future<void> openCamera();
}

class PermissionsClient implements IPermissionsClient {
  @override
  Future<void> openSettings() async {
    if (!await openAppSettings()) throw "Could not open app settings";
  }

  @override
  Future<void> openCamera() {
    // TODO: implement openCamera
    throw UnimplementedError();
  }
}