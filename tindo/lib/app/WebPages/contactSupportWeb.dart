import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class ContactSupportWeb extends StatefulWidget {
  const ContactSupportWeb({Key? key}) : super(key: key);

  @override
  State<ContactSupportWeb> createState() => _ContactSupportWebState();
}

class _ContactSupportWebState extends State<ContactSupportWeb> {
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
