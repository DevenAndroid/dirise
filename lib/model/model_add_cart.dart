class ModelAddOrder {
  bool? status;
  String? message;
  Data? data;

  ModelAddOrder({this.status, this.message, this.data});

  ModelAddOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['category'] = this.category;
    data['product_type'] = this.productType;
    data['quantity'] = this.quantity;
    data['product_price'] = this.productPrice;
    data['total_price'] = this.totalPrice;
    data['tax'] = this.tax;
    data['vendor_id'] = this.vendorId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
