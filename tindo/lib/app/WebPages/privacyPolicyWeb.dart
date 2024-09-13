import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class PrivacyPolicyWeb extends StatefulWidget {
  const PrivacyPolicyWeb({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyWeb> createState() => _PrivacyPolicyWebState();
}

class _PrivacyPolicyWebState extends State<PrivacyPolicyWeb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(privacyPolicyLink),
          ),
        ),
      ),
    );
  }
}
