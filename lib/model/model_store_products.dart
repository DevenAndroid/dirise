class ModelStoreProducts {
  bool? status;
  dynamic message;
  List<Data>? data = [];

  ModelStoreProducts({this.status, this.message, this.data});

  ModelStoreProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic catId2;
  dynamic catId3;
  dynamic slug;
  dynamic brandSlug;
  dynamic pname;
  dynamic productType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic taxApply;
  dynamic taxType;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic discountType;
  dynamic discount;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic virtualProductFile;
  dynamic virtualProductFileType;
  dynamic bookingProductType;
  dynamic virtualProductType;
  dynamic inStock;
  dynamic returnPolicyDesc;
  dynamic featured;
  dynamic bestSaller;
  dynamic shippingType;
  dynamic shippingCharge;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic parentId;
  dynamic commission;
  dynamic metaDescription;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic topHunderd;
  dynamic returnDays;
  dynamic arabPname;
  dynamic arabShortDescription;
  dynamic arabLongDescription;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic stockAlert;
  dynamic titleName;
  dynamic serviceDuration;

  Data(
      {this.id,
        this.vendorId,
        this.catId,
        this.catId2,
        this.catId3,
        this.slug,
        this.brandSlug,
        this.pname,
        this.productType,
        this.skuId,
        this.pPrice,
        this.sPrice,
        this.taxApply,
        this.taxType,
        this.shortDescription,
        this.longDescription,
        this.discountType,
        this.discount,
        this.featuredImage,
        this.galleryImage,
        this.virtualProductFile,
        this.virtualProductFileType,
        this.bookingProductType,
        this.virtualProductType,
        this.inStock,
        this.returnPolicyDesc,
        this.featured,
        this.bestSaller,
        this.shippingType,
        this.shippingCharge,
        this.metaTitle,
        this.metaKeyword,
        this.parentId,
        this.commission,
        this.metaDescription,
        this.serviceStartTime,
        this.serviceEndTime,
        this.topHunderd,
        this.returnDays,
        this.arabPname,
        this.arabShortDescription,
        this.arabLongDescription,
        this.isPublish,
        this.inOffer,
        this.forAuction,
        this.stockAlert,
        this.titleName,
        this.serviceDuration});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    catId3 = json['cat_id_3'];
    slug = json['slug'];
    brandSlug = json['brand_slug'];
    pname = json['pname'];
    productType = json['product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    taxApply = json['tax_apply'];
    taxType = json['tax_type'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    discountType = json['discount_type'];
    discount = json['discount'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'].toString() != "" && json['gallery_image'].toString() != "null" ?
    json['gallery_image'].cast<String>() : [];
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    bookingProductType = json['booking_product_type'];
    virtualProductType = json['virtual_product_type'];
    inStock = json['in_stock'];
    returnPolicyDesc = json['return_policy_desc'];
    featured = json['featured'];
    bestSaller = json['best_saller'];
    shippingType = json['shipping_type'];
    shippingCharge = json['shipping_charge'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    parentId = json['parent_id'];
    commission = json['commission'];
    metaDescription = json['meta_description'];
    serviceStartTime = json['service_start_time'];
    serviceEndTime = json['service_end_time'];
    topHunderd = json['top_hunderd'];
    returnDays = json['return_days'];
    arabPname = json['arab_pname'];
    arabShortDescription = json['arab_short_description'];
    arabLongDescription = json['arab_long_description'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];
    stockAlert = json['stock_alert'];
    titleName = json['title_name'];
    serviceDuration = json['service_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['cat_id_2'] = catId2;
    data['cat_id_3'] = catId3;
    data['slug'] = slug;
    data['brand_slug'] = brandSlug;
    data['pname'] = pname;
    data['product_type'] = productType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['tax_apply'] = taxApply;
    data['tax_type'] = taxType;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['discount_type'] = discountType;
    data['discount'] = discount;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['booking_product_type'] = bookingProductType;
    data['virtual_product_type'] = virtualProductType;
    data['in_stock'] = inStock;
    data['return_policy_desc'] = returnPolicyDesc;
    data['featured'] = featured;
    data['best_saller'] = bestSaller;
    data['shipping_type'] = shippingType;
    data['shipping_charge'] = shippingCharge;
    data['meta_title'] = metaTitle;
    data['meta_keyword'] = metaKeyword;
    data['parent_id'] = parentId;
    data['commission'] = commission;
    data['meta_description'] = metaDescription;
    data['service_start_time'] = serviceStartTime;
    data['service_end_time'] = serviceEndTime;
    data['top_hunderd'] = topHunderd;
    data['return_days'] = returnDays;
    data['arab_pname'] = arabPname;
    data['arab_short_description'] = arabShortDescription;
    data['arab_long_description'] = arabLongDescription;
    data['is_publish'] = isPublish;
    data['in_offer'] = inOffer;
    data['for_auction'] = forAuction;
    data['stock_alert'] = stockAlert;
    data['title_name'] = titleName;
    data['service_duration'] = serviceDuration;
    return data;
  }
}
