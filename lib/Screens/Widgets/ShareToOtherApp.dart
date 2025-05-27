import 'package:share_plus/share_plus.dart';

class ShareToOtherApp {
  static void share() {
    Share.share(
      'Please find\nhttps://www.google.com',
      subject: 'Test',
    );
  }
}
