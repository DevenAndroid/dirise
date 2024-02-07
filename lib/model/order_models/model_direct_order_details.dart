import 'package:get/get.dart';

import '../product_model/model_product_element.dart';

class ModelDirectOrderResponse {
  bool? status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  dynamic total;
  dynamic discount;
  List<ShippingType>? shippingType;
  RxString shippingOption = "".obs;
  int quantity = 1;
  ReturnData? returnData;
  ProductElement? prodcutData;

  ModelDirectOrderResponse(
      {this.status,
      this.message,
      this.subtotal,
      this.shipping,
      this.total,
      this.discount,
      this.returnData,
      this.shippingType,
      this.prodcutData});

  ModelDirectOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    total = json['total'];
    discount = json['discount'];
    shipping = json['shipping'];
    // if (json['shipping_types'] != null) {
    //   shippingType = <ShippingType>[];
    //   json['shipping_types'].forEach((v) {
    //     shippingType!.add(ShippingType.fromJson(v));
    //   });
    // }
    if (json['shipping_type'] != null) {
      shippingType = <ShippingType>[];
      json['shipping_type'].forEach((v) { shippingType!.add(ShippingType.fromJson(v)); });
    }
    returnData = json['return_data'] != null ? ReturnData.fromJson(json['return_data']) : null;
    prodcutData = json['prodcut_data'] != null ? ProductElement.fromJson(json['prodcut_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['subtotal'] = subtotal;
    data['shipping'] = shipping;
    data['total'] = total;
    data['discount'] = discount;
    if (shippingType != null) {
      data['shipping_type'] = shippingType!.map((v) => v.toJson()).toList();
    }
    if (returnData != null) {
      data['return_data'] = returnData!.toJson();
    }
    if (prodcutData != null) {
      data['prodcut_data'] = prodcutData!.toJson();
    }
    return data;
  }
}
class ShippingType {
  int? id;
  String? name;
  String? value;
  int? vendorId;

  ShippingType({this.id, this.name, this.value, this.vendorId});

  ShippingType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    value = json['value'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['value'] = this.value;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}
class ReturnData {
  dynamic startDate;
  dynamic timeSloat;
  dynamic sloatEndTime;
  dynamic quantity;

  ReturnData({this.startDate, this.timeSloat, this.sloatEndTime, this.quantity});

  ReturnData.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    timeSloat = json['time_sloat'];
    sloatEndTime = json['sloat_end_time'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start_date'] = startDate;
    data['time_sloat'] = timeSloat;
    data['sloat_end_time'] = sloatEndTime;
    data['quantity'] = quantity;
    return data;
  }
}