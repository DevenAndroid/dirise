import 'dart:io';

import 'package:flutter/cupertino.dart';

import 'model_attribute.dart';

class AddMultipleItems {
  Map<String, GetAttrvalues>? attributes = {};
  File variantImages = File("");
  final GlobalKey variantImageKey = GlobalKey();
  TextEditingController variantSku = TextEditingController();
  TextEditingController variantPrice = TextEditingController();
  TextEditingController variantStock = TextEditingController();

  AddMultipleItems({
    this.attributes,
  });
}