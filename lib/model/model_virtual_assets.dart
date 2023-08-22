class ModelVirtualAssets {
  bool? status;
  dynamic message;
  Order? order;
  dynamic totalPage;

  ModelVirtualAssets({this.status, this.message, this.order, this.totalPage});

  ModelVirtualAssets.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    data['total_page'] = totalPage;
    return data;
  }
}

class Order {
  dynamic currentPage;
  List<Data>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  Order(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Order.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Data {
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
  dynamic deliveryType;
  dynamic grandTotal;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic childId;
  dynamic productId;
  dynamic vendorId;
  dynamic productName;
  dynamic category;
  dynamic productType;
  dynamic virtualProductType;
  dynamic quantity;
  dynamic productPrice;
  dynamic discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic startDate;
  dynamic sloatTime;
  dynamic sloatEndTime;
  dynamic endDate;
  dynamic variation;
  dynamic featuredImage;
  dynamic galleryImage;
  dynamic products;

  Data(
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
        this.deliveryType,
        this.grandTotal,
        this.createdAt,
        this.updatedAt,
        this.childId,
        this.productId,
        this.vendorId,
        this.productName,
        this.category,
        this.productType,
        this.virtualProductType,
        this.quantity,
        this.productPrice,
        this.discount,
        this.totalPrice,
        this.tax,
        this.startDate,
        this.sloatTime,
        this.sloatEndTime,
        this.endDate,
        this.variation,
        this.featuredImage,
        this.galleryImage,
        this.products});

  Data.fromJson(Map<String, dynamic> json) {
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
    deliveryType = json['delivery_type'];
    grandTotal = json['grand_total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    virtualProductType = json['virtual_product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    sloatEndTime = json['sloat_end_time'];
    endDate = json['end_date'];
    variation = json['variation'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'];
    products = json['products'];
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
    data['delivery_type'] = deliveryType;
    data['grand_total'] = grandTotal;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['child_id'] = childId;
    data['product_id'] = productId;
    data['vendor_id'] = vendorId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['virtual_product_type'] = virtualProductType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['sloat_end_time'] = sloatEndTime;
    data['end_date'] = endDate;
    data['variation'] = variation;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['products'] = products;
    return data;
  }
}

class Links {
  dynamic url;
  dynamic label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
