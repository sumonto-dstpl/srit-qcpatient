import 'package:share_plus/share_plus.dart';

class ShareToOtherApp {
static Future<void> share() async {
    Share.share(
      'Please find\nhttps://www.google.com',
      subject: 'Test',
    );
  }
}
