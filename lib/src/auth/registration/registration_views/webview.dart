import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart'; // Ensure you import the correct package
import 'package:dio/dio.dart';
import 'package:phincash/services/dio_services/dio_services.dart';
import 'package:phincash/src/auth/registration/registration_views/selfie_page.dart';
import 'package:get/get.dart';
import 'package:phincash/utils/helpers/progress_dialog_helper.dart';
import 'package:phincash/src/auth/registration/registration_views/collect_banks_details.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isWebViewVisible = true;

  WebViewController? webViewController;

  void closeWebView() {
    setState(() {
      isWebViewVisible = false;
    });
  }

  Future<void> updateOnBoardingStage() async {
    try {
      // Perform the onBoardingStage update
      // This code should be here or inside the function you're calling
      await DioServices().onBoardingStage(onBoardStage: "upload_profile_Photo");
    } catch (err) {
      // Handle errors if needed
      // You can show an error message or log the error
      print("Error updating onBoardingStage: $err");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bind Card')),
      body: isWebViewVisible
          ? WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          webViewController = controller;
          webViewController?.loadUrl(widget.url);
        },
        onPageFinished: (url) {
          // Page load completed
          if (url.contains('status=successful')) {
            // Payment is successful, close the WebView
            //closeWebView();

            // Update onBoardingStage and navigate to CameraApp
            updateOnBoardingStage().then((_) {
              ProgressDialogHelper().hideProgressDialog(Get.context!);
              Get.off(() => CameraApp(id: DateTime.now().toString()));
            });
          } else if (url.contains('status=')) {
            // Display a message for non-successful transactions
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Card Binding Transaction Failed'),
                  content: Text('The card binding transaction was not successful.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Close the WebView and go back to the previous screen
                        // You may need to adjust this logic based on your navigation setup
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          } else {
    // Display a generic error message for unexpected situations
    showDialog(
    context: context,
    builder: (BuildContext context) {
    return AlertDialog(
    title: Text('Unexpected Error'),
    content: Text('An unexpected error occurred during the card binding transaction.'),
    actions: <Widget>[
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();

    // Navigate to CollectUserBankDetails page
    Get.offAll(() => const CollectUserBankDetails());
    },
    child: Text('OK'),
    ),
    ],
    );
    },
    );
    }
        },
      )
          : Container(), // WebView is hidden
    );
  }

}
