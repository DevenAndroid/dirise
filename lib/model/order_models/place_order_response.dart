class ModelPlaceOrderResponse {
  bool? status;
  String? message;
  dynamic order_id;

  ModelPlaceOrderResponse({this.status, this.message, this.order_id});

  ModelPlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order_id = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['order_id'] = order_id;
    return data;
  }
}
