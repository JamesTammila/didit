import 'package:share_plus/share_plus.dart';

abstract class IShareClient {
  Future<void> shareLink();
}

class ShareClient implements IShareClient {
  @override
  Future<void> shareLink() async {
    await Share.share('https://dewdrop.app/');
  }
}