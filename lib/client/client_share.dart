import 'package:share_plus/share_plus.dart';

abstract class IShareClient {
  Future<void> shareLink();
}

class ShareClient implements IShareClient {
  static const String link = 'https://dewdrop.app/';

  @override
  Future<void> shareLink() async {
    await Share.share(link);
  }
}