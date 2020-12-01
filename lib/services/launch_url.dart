import 'package:url_launcher/url_launcher.dart';

launchURL(String url,
    {bool forceWebView = false, bool enableJavascript}) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceWebView: forceWebView,
        enableJavaScript: enableJavascript ?? forceWebView);
  } else {
    throw 'Could not launch $url';
  }
}
