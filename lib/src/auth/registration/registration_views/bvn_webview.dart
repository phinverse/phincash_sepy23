import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:phincash/constants/constants.dart';
import 'package:phincash/src/auth/registration/controller/registration_controller.dart';


class BvnWebView extends StatefulWidget {
  final String url;

  BvnWebView({required this.url});
  @override
  _BvnWebViewState createState() => _BvnWebViewState();
}

class _BvnWebViewState extends State<BvnWebView> {
  bool _isLoadingPage = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onProgress: (int progress) {
              print("WebView is loading (progress : $progress%)");
            },
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: (_) {
              setState(() {
                _isLoadingPage = false;
              });
            },
            navigationDelegate: (NavigationRequest request) {
              print('Navigating to: ${request.url}');
              if (request.url
                  .startsWith('https://api.ravepay.co')) {
                Uri uri = Uri.parse(request.url);
                if (uri.queryParameters['status'] == 'success') {
                  RegistrationController().saveBankDetailsUser(
                      accountName: savedBankAccountName,
                      accountNumber: savedBankAccountNumber,
                      bankName: savedBankName,
                      bankCode: savedBankCode);
                  return NavigationDecision.prevent;
                } else {
                  Get.back();
                  Get.defaultDialog(
                    title: 'Error',
                    middleText: 'Request not processed successfully',
                    textConfirm: 'OK',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      if (Get.isDialogOpen!) {
                        Get.back();
                      }
                    },
                  );
                  return NavigationDecision.prevent;
                }
              }
              return NavigationDecision.navigate;
            },
            gestureNavigationEnabled: false,
            geolocationEnabled: false, //support geolocation or not
            // other configurations...
          ),
          _isLoadingPage
              ? Center(child: CircularProgressIndicator())
              : Container(),
        ],
      ),
    );
  }
}
