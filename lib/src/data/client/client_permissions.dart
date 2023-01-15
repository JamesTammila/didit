abstract class IPermissionsClient {
  Future<void> openCamera();
}

class PermissionsClient implements IPermissionsClient {
  @override
  Future<void> openCamera() {
    // TODO: implement openCamera
    throw UnimplementedError();
  }
}