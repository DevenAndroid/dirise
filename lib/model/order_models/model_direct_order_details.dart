class ModelDirectOrderResponse {
  bool? status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  dynamic total;
  dynamic discount;
  ReturnData? returnData;
  ProdcutData? prodcutData;

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
    returnData = json['return_data'] != null
        ? ReturnData.fromJson(json['return_data'])
        : null;
    prodcutData = json['prodcut_data'] != null
        ? ProdcutData.fromJson(json['prodcut_data'])
        : null;
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

  ReturnData(
      {this.startDate, this.timeSloat, this.sloatEndTime, this.quantity});

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

class ProdcutData {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic catId2;
  dynamic catId3;
  dynamic brandSlug;
  dynamic slug;
  dynamic pname;
  dynamic prodectImage;
  dynamic prodectName;
  dynamic prodectSku;
  dynamic code;
  dynamic bookingProductType;
  dynamic prodectPrice;
  dynamic prodectMinQty;
  dynamic prodectMixQty;
  dynamic prodectDescription;
  dynamic image;
  dynamic arabPname;
  dynamic productType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic bestSaller;
  dynamic featured;
  dynamic taxApply;
  dynamic taxType;
  dynamic shortDescription;
  dynamic arabShortDescription;
  dynamic longDescription;
  dynamic arabLongDescription;
  dynamic featuredImage;
  dynamic galleryImage;
  dynamic virtualProductFile;
  dynamic virtualProductFileType;
  dynamic inStock;
  dynamic stockAlert;
  dynamic shippingType;
  dynamic shippingCharge;
  dynamic avgRating;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic metaDescription;
  dynamic parentId;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic serviceDuration;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic topHunderd;
  dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic returnPolicyDesc;

  ProdcutData(
      {this.id,
      this.vendorId,
      this.catId,
      this.catId2,
      this.catId3,
      this.brandSlug,
      this.slug,
      this.pname,
      this.prodectImage,
      this.prodectName,
      this.prodectSku,
      this.code,
      this.bookingProductType,
      this.prodectPrice,
      this.prodectMinQty,
      this.prodectMixQty,
      this.prodectDescription,
      this.image,
      this.arabPname,
      this.productType,
      this.skuId,
      this.pPrice,
      this.sPrice,
      this.commission,
      this.bestSaller,
      this.featured,
      this.taxApply,
      this.taxType,
      this.shortDescription,
      this.arabShortDescription,
      this.longDescription,
      this.arabLongDescription,
      this.featuredImage,
      this.galleryImage,
      this.virtualProductFile,
      this.virtualProductFileType,
      this.inStock,
      this.stockAlert,
      this.shippingType,
      this.shippingCharge,
      this.avgRating,
      this.metaTitle,
      this.metaKeyword,
      this.metaDescription,
      this.parentId,
      this.serviceStartTime,
      this.serviceEndTime,
      this.serviceDuration,
      this.createdAt,
      this.updatedAt,
      this.topHunderd,
      this.returnDays,
      this.isPublish,
      this.inOffer,
      this.forAuction,
      this.returnPolicyDesc});

  ProdcutData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    catId3 = json['cat_id_3'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    prodectImage = json['prodect_image'];
    prodectName = json['prodect_name'];
    prodectSku = json['prodect_sku'];
    code = json['code'];
    bookingProductType = json['booking_product_type'];
    prodectPrice = json['prodect_price'];
    prodectMinQty = json['prodect_min_qty'];
    prodectMixQty = json['prodect_mix_qty'];
    prodectDescription = json['prodect_description'];
    image = json['image'];
    arabPname = json['arab_pname'];
    productType = json['product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    commission = json['commission'];
    bestSaller = json['best_saller'];
    featured = json['featured'];
    taxApply = json['tax_apply'];
    taxType = json['tax_type'];
    shortDescription = json['short_description'];
    arabShortDescription = json['arab_short_description'];
    longDescription = json['long_description'];
    arabLongDescription = json['arab_long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'];
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    inStock = json['in_stock'];
    stockAlert = json['stock_alert'];
    shippingType = json['shipping_type'];
    shippingCharge = json['shipping_charge'];
    avgRating = json['avg_rating'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    parentId = json['parent_id'];
    serviceStartTime = json['service_start_time'];
    serviceEndTime = json['service_end_time'];
    serviceDuration = json['service_duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topHunderd = json['top_hunderd'];
    returnDays = json['return_days'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];
    returnPolicyDesc = json['return_policy_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['cat_id_2'] = catId2;
    data['cat_id_3'] = catId3;
    data['brand_slug'] = brandSlug;
    data['slug'] = slug;
    data['pname'] = pname;
    data['prodect_image'] = prodectImage;
    data['prodect_name'] = prodectName;
    data['prodect_sku'] = prodectSku;
    data['code'] = code;
    data['booking_product_type'] = bookingProductType;
    data['prodect_price'] = prodectPrice;
    data['prodect_min_qty'] = prodectMinQty;
    data['prodect_mix_qty'] = prodectMixQty;
    data['prodect_description'] = prodectDescription;
    data['image'] = image;
    data['arab_pname'] = arabPname;
    data['product_type'] = productType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['commission'] = commission;
    data['best_saller'] = bestSaller;
    data['featured'] = featured;
    data['tax_apply'] = taxApply;
    data['tax_type'] = taxType;
    data['short_description'] = shortDescription;
    data['arab_short_description'] = arabShortDescription;
    data['long_description'] = longDescription;
    data['arab_long_description'] = arabLongDescription;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['in_stock'] = inStock;
    data['stock_alert'] = stockAlert;
    data['shipping_type'] = shippingType;
    data['shipping_charge'] = shippingCharge;
    data['avg_rating'] = avgRating;
    data['meta_title'] = metaTitle;
    data['meta_keyword'] = metaKeyword;
    data['meta_description'] = metaDescription;
    data['parent_id'] = parentId;
    data['service_start_time'] = serviceStartTime;
    data['service_end_time'] = serviceEndTime;
    data['service_duration'] = serviceDuration;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_hunderd'] = topHunderd;
    data['return_days'] = returnDays;
    data['is_publish'] = isPublish;
    data['in_offer'] = inOffer;
    data['for_auction'] = forAuction;
    data['return_policy_desc'] = returnPolicyDesc;
    return data;
  }
}
