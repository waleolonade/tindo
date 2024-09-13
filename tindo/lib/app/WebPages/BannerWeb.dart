import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BannerWeb extends StatefulWidget {
  final String uri;
  const BannerWeb({Key? key, required this.uri}) : super(key: key);

  @override
  State<BannerWeb> createState() => _BannerWebState();
}

class _BannerWebState extends State<BannerWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(widget.uri),
          ),
        ),
      ),
    );
  }
}
