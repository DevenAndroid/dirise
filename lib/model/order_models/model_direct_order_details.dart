import '../product_model/model_product_element.dart';

class ModelDirectOrderResponse {
  bool? status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  dynamic total;
  dynamic discount;
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
      this.prodcutData});

  ModelDirectOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    subtotal = json['subtotal'];
    shipping = json['shipping'];
    total = json['total'];
    discount = json['discount'];
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
    if (returnData != null) {
      data['return_data'] = returnData!.toJson();
    }
    if (prodcutData != null) {
      data['prodcut_data'] = prodcutData!.toJson();
    }
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