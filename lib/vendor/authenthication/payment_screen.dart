import 'package:dirise/screens/app_bar/common_app_bar.dart';
import 'package:dirise/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
        ..setJavaScriptMode(JavaScriptMode.unrestricted);
      controller!.loadRequest(Uri.parse(widget.paymentUrl)).then((value) {
        webLoaded = true;
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(titleText: "Payment"),
      body: webLoaded ? WebViewWidget(controller: controller!) : const LoadingAnimation(),
    );
  }
}
