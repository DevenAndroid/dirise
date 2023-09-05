import 'dart:developer';

import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/utils/ApiConstant.dart';
import 'package:dirise/vendor/authenthication/thanku_screen.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../dashboard/dashboard_screen.dart';

class VendorPaymentScreen extends StatefulWidget {
  const VendorPaymentScreen({super.key, required this.paymentUrl});
  final String paymentUrl;

  @override
  State<VendorPaymentScreen> createState() => _VendorPaymentScreenState();
}

class _VendorPaymentScreenState extends State<VendorPaymentScreen> {

  WebViewController? controller;
  bool webLoaded = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          log("Navigation Request....      ${request.url}");
          if(request.url.contains(navigationBackUrl)){
            showToast("Payment Successfully");
            Get.back();
            Get.off(() => const VendorDashBoardScreen());
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),)
        ..setJavaScriptMode(JavaScriptMode.unrestricted);
      controller!.loadRequest(Uri.parse(widget.paymentUrl)).then((value) {
        webLoaded = true;
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller!.clearCache();
    controller!.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        if(await controller!.canGoBack()){
          controller!.goBack();
        }
        return false;
      },
      child: Scaffold(
        appBar: const CommonAppBar(titleText: "Payment",backGroundColor: Colors.transparent,),
        body: webLoaded ? WebViewWidget(
            controller: controller!,
        ) : const LoadingAnimation(),
      ),
    );
  }
}
