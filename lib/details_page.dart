import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class DetailsPage extends StatelessWidget {
  DetailsPage({super.key, this.url});
  final String? url;
  final webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setNavigationDelegate(NavigationDelegate(onPageStarted: (String url) {
      // Show loader
      const CircularProgressIndicator(
        color: Colors.blue,
      );
    }, onPageFinished: (String url) {
      // Hide loader
    }));

  @override
  Widget build(BuildContext context) {
    webViewController.loadRequest(Uri.parse(url!));
    return Scaffold(
      body: SafeArea(
        child: WebViewWidget(
          controller: webViewController,
        ),
      ),
    );
  }
}
