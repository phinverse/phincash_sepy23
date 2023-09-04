import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import '../../../../constants/app_string.dart';

class VerificationWebView extends StatefulWidget {
  const VerificationWebView({Key? key, required this.url}) : super(key: key);

  @override
  VerificationWebViewState createState() => VerificationWebViewState();
  final String url;
}

class VerificationWebViewState extends State<VerificationWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Verification",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 20,
              fontFamily: AppString.latoFontStyle,
              fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
            onPressed: () {
              Get.offAll(() => HomeScreen());
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 20,
            )),
      ),
      body: WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
        },
      ),
    );
  }
}
