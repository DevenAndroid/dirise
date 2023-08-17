import 'package:get/get.dart';

class ModelSingleOrderResponse {
  bool? status;
  dynamic message;
  SingleOrderData? order;

  ModelSingleOrderResponse({this.status, this.message, this.order});

  ModelSingleOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order = json['order'] != null ? SingleOrderData.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class SingleOrderData {
  dynamic id;
  dynamic parentId;
  dynamic orderId;
  dynamic userId;
  dynamic status;
  dynamic statusNote;
  dynamic shippingType;
  dynamic shippingPrice;
  dynamic shippingMethod;
  dynamic paymentMode;
  dynamic paymentStatus;
  dynamic currencyCode;
  dynamic couponId;
  dynamic couponCode;
  dynamic discountAmount;
  dynamic updatedAt;
  dynamic createdDate;
  OrderMeta? orderMeta;
  dynamic expectedDate;
  List<OrderItem>? orderItem = [];

  SingleOrderData(
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
      this.updatedAt,
      this.createdDate,
      this.orderMeta,
      this.expectedDate,
      this.orderItem});

  SingleOrderData.fromJson(Map<String, dynamic> json) {
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
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    orderMeta = json['order_meta'] != null ? OrderMeta.fromJson(json['order_meta']) : null;
    expectedDate = json['expected_date'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    } else {
      orderItem = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['status'] = status;
    data['status_note'] = statusNote;
    data['shipping_type'] = shippingType;
    data['shipping_price'] = shippingPrice;
    data['shipping_method'] = shippingMethod;
    data['payment_mode'] = paymentMode;
    data['payment_status'] = paymentStatus;
    data['currency_code'] = currencyCode;
    data['coupon_id'] = couponId;
    data['coupon_code'] = couponCode;
    data['discount_amount'] = discountAmount;
    data['updated_at'] = updatedAt;
    data['created_date'] = createdDate;
    if (orderMeta != null) {
      data['order_meta'] = orderMeta!.toJson();
    }
    data['expected_date'] = expectedDate;
    if (orderItem != null) {
      data['order_item'] = orderItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderMeta {
  dynamic billingFirstName;
  dynamic billingLastName;
  dynamic billingPhone;
  dynamic billingAlternatePhone;
  dynamic billingAddress2;
  dynamic billingAddressType;
  dynamic billingCity;
  dynamic billingCountry;
  dynamic billingState;
  dynamic billingZipCode;
  dynamic billingLandmark;
  dynamic subtotalPrice;
  dynamic totalPrice;
  dynamic giftCardAmount;
  dynamic giftCardData;
  dynamic currencySign;
  dynamic shippingPrice;
  // List<Shipping>? shipping;
  dynamic shippingFirstName;
  dynamic shippingLastName;
  dynamic shippingPhone;
  dynamic shippingAlternatePhone;
  dynamic shippingAddress2;
  dynamic shippingAddressType;
  dynamic shippingCity;
  dynamic shippingCountry;
  dynamic shippingState;
  dynamic shippingZipCode;
  dynamic shippingLandmark;
  dynamic refundAmountIn;

  OrderMeta(
      {this.billingFirstName,
      this.billingLastName,
      this.billingPhone,
      this.billingAlternatePhone,
      this.billingAddress2,
      this.billingAddressType,
      this.billingCity,
      this.billingCountry,
      this.billingState,
      this.billingZipCode,
      this.billingLandmark,
      this.subtotalPrice,
      this.totalPrice,
      this.giftCardAmount,
      this.giftCardData,
      this.currencySign,
      this.shippingPrice,
      // this.shipping,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingPhone,
      this.shippingAlternatePhone,
      this.shippingAddress2,
      this.shippingAddressType,
      this.shippingCity,
      this.shippingCountry,
      this.shippingState,
      this.shippingZipCode,
      this.shippingLandmark,
      this.refundAmountIn});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingPhone = json['billing_phone'];
    billingAlternatePhone = json['billing_alternate_phone'];
    billingAddress2 = json['billing_address2'];
    billingAddressType = json['billing_address_type'];
    billingCity = json['billing_city'];
    billingCountry = json['billing_country'];
    billingState = json['billing_state'];
    billingZipCode = json['billing_zip_code'];
    billingLandmark = json['billing_landmark'];
    subtotalPrice = json['subtotal_price'];
    totalPrice = json['total_price'];
    giftCardAmount = json['gift_card_amount'];
    giftCardData = json['gift_card_data'];
    currencySign = json['currency_sign'];
    shippingPrice = json['shipping_price'];
    // if (json['shipping'] != null) {
    //   shipping = <Shipping>[];
    //   json['shipping'].forEach((v) {
    //     shipping!.add(Shipping.fromJson(v));
    //   });
    // }
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingPhone = json['shipping_phone'];
    shippingAlternatePhone = json['shipping_alternate_phone'];
    shippingAddress2 = json['shipping_address2'];
    shippingAddressType = json['shipping_address_type'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingZipCode = json['shipping_zip_code'];
    shippingLandmark = json['shipping_landmark'];
    refundAmountIn = json['refund_amount_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billing_first_name'] = billingFirstName;
    data['billing_last_name'] = billingLastName;
    data['billing_phone'] = billingPhone;
    data['billing_alternate_phone'] = billingAlternatePhone;
    data['billing_address2'] = billingAddress2;
    data['billing_address_type'] = billingAddressType;
    data['billing_city'] = billingCity;
    data['billing_country'] = billingCountry;
    data['billing_state'] = billingState;
    data['billing_zip_code'] = billingZipCode;
    data['billing_landmark'] = billingLandmark;
    data['subtotal_price'] = subtotalPrice;
    data['total_price'] = totalPrice;
    data['gift_card_amount'] = giftCardAmount;
    data['gift_card_data'] = giftCardData;
    data['currency_sign'] = currencySign;
    data['shipping_price'] = shippingPrice;
    // if (shipping != null) {
    //   data['shipping'] = shipping!.map((v) => v.toJson()).toList();
    // }
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
    data['shipping_phone'] = shippingPhone;
    data['shipping_alternate_phone'] = shippingAlternatePhone;
    data['shipping_address2'] = shippingAddress2;
    data['shipping_address_type'] = shippingAddressType;
    data['shipping_city'] = shippingCity;
    data['shipping_country'] = shippingCountry;
    data['shipping_state'] = shippingState;
    data['shipping_zip_code'] = shippingZipCode;
    data['shipping_landmark'] = shippingLandmark;
    data['refund_amount_in'] = refundAmountIn;
    return data;
  }
}

class Shipping {
  dynamic storeId;
  dynamic storeName;
  dynamic title;
  dynamic shipPrice;

  Shipping({this.storeId, this.storeName, this.title, this.shipPrice});

  Shipping.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    title = json['title'];
    shipPrice = json['ship_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['title'] = title;
    data['ship_price'] = shipPrice;
    return data;
  }
}

class OrderItem {
  RxBool showDetails = false.obs;
  dynamic id;
  dynamic selectedSlotStart;
  dynamic selectedSlotEnd;
  dynamic selectedSlotDate;
  dynamic orderId;
  dynamic childId;
  dynamic productId;
  dynamic vendorId;
  dynamic userId;
  dynamic productName;
  dynamic category;
  dynamic productType;
  dynamic quantity;
  dynamic productPrice;
  dynamic discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic status;
  dynamic startDate;
  dynamic sloatTime;
  dynamic endDate;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic featuredImage;

  OrderItem(
      {this.id,
      this.selectedSlotStart,
      this.selectedSlotEnd,
      this.selectedSlotDate,
      this.orderId,
      this.childId,
      this.productId,
      this.vendorId,
      this.userId,
      this.productName,
      this.category,
      this.productType,
      this.quantity,
      this.productPrice,
      this.discount,
      this.totalPrice,
      this.tax,
      this.status,
      this.startDate,
      this.sloatTime,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.featuredImage});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selectedSlotStart = json["selected_sloat_start"];
    selectedSlotEnd = json["selected_sloat_end"];
    selectedSlotDate = json["selected_sloat_date"];
    orderId = json['order_id'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    status = json['status'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    featuredImage = json['featured_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['child_id'] = childId;
    data['product_id'] = productId;
    data['vendor_id'] = vendorId;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['status'] = status;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['featured_image'] = featuredImage;
    return data;
  }
}
