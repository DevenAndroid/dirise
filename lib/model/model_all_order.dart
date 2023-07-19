class ModelDataOrder {
  bool? status;
  String? message;
  List<Order>? order;

  ModelDataOrder({this.status, this.message, this.order});

  ModelDataOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.order != null) {
      data['order'] = this.order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  int? id;
  int? parentId;
  int? orderId;
  int? userId;
  String? status;
  String? statusNote;
  String? shippingType;
  Null? shippingPrice;
  String? shippingMethod;
  String? paymentMode;
  String? paymentStatus;
  String? currencyCode;
  Null? couponId;
  Null? couponCode;
  String? discountAmount;
  String? createdAt;
  String? updatedAt;
  Null? childId;
  int? productId;
  int? vendorId;
  String? productName;
  String? category;
  String? productType;
  String? quantity;
  String? productPrice;
  Null? discount;
  int? totalPrice;
  int? tax;
  Null? startDate;
  Null? sloatTime;
  Null? endDate;
  List<Null>? products;

  Order(
      {this.id,
        this.parentId,
        this.orderId,
        this.userId,
        this.status,
        this.statusNote,
        this.shippingType,
        this.shippingPrice,
        this.shippingMethod,
        this.paymentMode,
        this.paymentStatus,
        this.currencyCode,
        this.couponId,
        this.couponCode,
        this.discountAmount,
        this.createdAt,
        this.updatedAt,
        this.childId,
        this.productId,
        this.vendorId,
        this.productName,
        this.category,
        this.productType,
        this.quantity,
        this.productPrice,
        this.discount,
        this.totalPrice,
        this.tax,
        this.startDate,
        this.sloatTime,
        this.endDate,
        this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    status = json['status'];
    statusNote = json['status_note'];
    shippingType = json['shipping_type'];
    shippingPrice = json['shipping_price'];
    shippingMethod = json['shipping_method'];
    paymentMode = json['payment_mode'];
    paymentStatus = json['payment_status'];
    currencyCode = json['currency_code'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    discountAmount = json['discount_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    endDate = json['end_date'];
    if (json['products'] != null) {
      products = <Null>[];
      // json['products'].forEach((v) {
      //   products!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['status'] = this.status;
    data['status_note'] = this.statusNote;
    data['shipping_type'] = this.shippingType;
    data['shipping_price'] = this.shippingPrice;
    data['shipping_method'] = this.shippingMethod;
    data['payment_mode'] = this.paymentMode;
    data['payment_status'] = this.paymentStatus;
    data['currency_code'] = this.currencyCode;
    data['coupon_id'] = this.couponId;
    data['coupon_code'] = this.couponCode;
    data['discount_amount'] = this.discountAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['child_id'] = this.childId;
    data['product_id'] = this.productId;
    data['vendor_id'] = this.vendorId;
    data['product_name'] = this.productName;
    data['category'] = this.category;
    data['product_type'] = this.productType;
    data['quantity'] = this.quantity;
    data['product_price'] = this.productPrice;
    data['discount'] = this.discount;
    data['total_price'] = this.totalPrice;
    data['tax'] = this.tax;
    data['start_date'] = this.startDate;
    data['sloat_time'] = this.sloatTime;
    data['end_date'] = this.endDate;
    // if (this.products != null) {
    //   data['products'] = this.products!.map((v) => v!.toJson()).toList();
    // }
    return data;
  }
}
