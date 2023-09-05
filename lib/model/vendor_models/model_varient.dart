import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'model_attribute.dart';

class AddMultipleItems {
  String? variantSku;
  Map<String, GetAttrvalues>? attributes = {};
  String? variantPrice;
  String? variantStock;
  File? variantImages = File("");
  final GlobalKey variantSkuKey = GlobalKey();
  final GlobalKey variantPriceKey = GlobalKey();
  final GlobalKey variantStockKey = GlobalKey();
  final GlobalKey variantImageKey = GlobalKey();

  AddMultipleItems({
    this.variantSku,
    this.variantPrice,
    this.attributes,
    this.variantStock,
    this.variantImages,
  });

  // AddMultipleItems.fromJson(Map<String, dynamic> json) {
  //   // variantSku =
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //
  //   return data;
  // }
}