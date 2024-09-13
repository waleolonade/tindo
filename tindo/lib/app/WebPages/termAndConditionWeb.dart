import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:rayzi/app/data/APP_variables/AppVariable.dart';

class TermAndConditionweb extends StatefulWidget {
  const TermAndConditionweb({Key? key}) : super(key: key);

  @override
  State<TermAndConditionweb> createState() => _TermAndConditionwebState();
}

class _TermAndConditionwebState extends State<TermAndConditionweb> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(termAndCondition),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(privacyPolicyLink),
        ),
      ),
    );
  }
}
