class ModelPlaceOrderResponse {
  bool? status;
  String? message;
  Data? data;

  ModelPlaceOrderResponse({this.status, this.message, this.data});

  ModelPlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? orderId;
  int? productId;
  String? productName;
  int? category;
  String? productType;
  String? quantity;
  int? productPrice;
  int? totalPrice;
  int? tax;
  int? vendorId;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
        this.orderId,
        this.productId,
        this.productName,
        this.category,
        this.productType,
        this.quantity,
        this.productPrice,
        this.totalPrice,
        this.tax,
        this.vendorId,
        this.updatedAt,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    vendorId = json['vendor_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['vendor_id'] = vendorId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    return data;
  }
}
