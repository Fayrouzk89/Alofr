import 'dart:io';
import 'package:billing/shared/widgets/AppBars/titled_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../shared/constants/colors.dart';
import '../../shared/services/LocalString.dart';
import '../../globals.dart' as globals;

class WebViewScreen extends StatefulWidget {


  WebViewScreen({Key? key}) : super(key: key);

  @override
  _PackageHomePageState createState() {
    return _PackageHomePageState();
  }

}

class _PackageHomePageState extends State<WebViewScreen> {
  WebViewController? controllerHome;
  bool connectionStatus=true;
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildForms(context);
  }

  Widget _buildForms(BuildContext context) {
    return  WillPopScope(
        onWillPop: () async => true,
        child: Scaffold(
          backgroundColor: ColorConstants.greyBack,
          appBar: TitledAppBar(
              LocalString.getStringValue(context, 'buy_now') ?? "ادفع الآن"),
          body:
            WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                controllerHome = controller;

              },
              navigationDelegate: (NavigationRequest request) {
                //TODO here is where we can allow or block navigation;
                debugPrint("Navigating " + request.url.toString());

                return NavigationDecision.navigate;
              },
              onPageFinished: (url) {
                setState(() {
                });
              },
              onPageStarted: (url) {
                setState(() {
                });
              },
           //   userAgent: globals.userAgent + ' ' + _webUserAgent,
              initialUrl: globals.mainUrl,
             // key: _firstWebViewKey,
              javascriptChannels: Set.from([
                JavascriptChannel(
                    name: 'Print',
                    onMessageReceived: (JavascriptMessage message) {
                      print(message.message);

                    })
              ]),
              onWebResourceError: (WebResourceError error) {
                check();
                setState(() {
                  connectionStatus = false;
                });
              },
              gestureNavigationEnabled: true,
            )


        )
    );

  }
  Future check() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connectionStatus = true;
        setState(() {});
        // print("connected $connectionStatus");
      }
    } on SocketException catch (_) {
      connectionStatus = false;
      setState(() {});
    }
  }

}
