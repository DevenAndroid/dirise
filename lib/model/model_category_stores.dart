class ModelCategoryStores {
  bool? status;
  dynamic message;
  User? user;
  dynamic categoryName;
  dynamic totalPage;
  List<Product>? product = [];
  List<PromotionData>? promotionData = [];

  ModelCategoryStores(
      {this.status, this.message, this.user, this.categoryName, this.promotionData, this.totalPage, this.product});

  ModelCategoryStores.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : User(data: []);
    categoryName = json['category_name'];
    totalPage = json['total_page'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    promotionData ??= [];
    if (json['goldData'] != null) {
      promotionData!.add(PromotionData.fromJson(json['goldData']));
    }
    if (json['silverData'] != null) {
      promotionData!.add(PromotionData.fromJson(json['silverData']));
    }
    if (json['bronzeData'] != null) {
      promotionData!.add(PromotionData.fromJson(json['bronzeData']));
    }
    // if (json['promotion_data'] != null) {
    //   promotionData = <PromotionData>[];
    //   json['promotion_data'].forEach((v) { promotionData!.add(PromotionData.fromJson(v)); });
    // } else {
    //   promotionData = [];
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['category_name'] = categoryName;
    data['total_page'] = totalPage;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  dynamic currentPage;
  List<VendorStoreData>? data = [];
  List<Links>? links;

  User({
    this.currentPage,
    this.data,
    this.links,
  });

  User.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <VendorStoreData>[];
      json['data'].forEach((v) {
        data!.add(VendorStoreData.fromJson(v));
      });
    } else {
      data = [];
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorStoreData {
  dynamic id;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic storeName;
  dynamic email;
  dynamic storePhone;
  dynamic description;

  VendorStoreData({this.id, this.storeLogo, this.storeImage, this.storeName, this.email, this.storePhone, this.description});

  VendorStoreData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'] ?? "";
    storeImage = json['store_image'] ?? "";
    storeName = json['store_name'] ?? "Store $id";
    email = json['email'] ?? "";
    storePhone = json['store_phone'] ?? "";
    description = json['description'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_name'] = storeName;
    data['email'] = email;
    data['store_phone'] = storePhone;
    data['description'] = description;
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

class Product {
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
  List<String>? galleryImage;
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
  bool? inCart;
  bool? inWishlist;
  dynamic currencySign;
  dynamic currencyCode;
  Storemeta? storemeta;
  bool? allowBid;
  dynamic nextBidPrice;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;

  Product(
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
      this.returnPolicyDesc,
      this.inCart,
      this.inWishlist,
      this.currencySign,
      this.currencyCode,
      this.storemeta,
      this.allowBid,
      this.nextBidPrice,
      this.serviceTimeSloat,
      this.productAvailability});

  Product.fromJson(Map<String, dynamic> json) {
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
    galleryImage = json['gallery_image'].cast<String>();
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
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
    currencySign = json['currency_sign'];
    currencyCode = json['currency_code'];
    storemeta = json['storemeta'] != null ? Storemeta.fromJson(json['storemeta']) : null;
    allowBid = json['allow_bid'];
    nextBidPrice = json['next_bid_price'];
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(ServiceTimeSloat.fromJson(v));
      });
    }
    productAvailability =
        json['productAvailability'] != null ? ProductAvailability.fromJson(json['productAvailability']) : null;
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
    data['in_cart'] = inCart;
    data['in_wishlist'] = inWishlist;
    data['currency_sign'] = currencySign;
    data['currency_code'] = currencyCode;
    if (storemeta != null) {
      data['storemeta'] = storemeta!.toJson();
    }
    data['allow_bid'] = allowBid;
    data['next_bid_price'] = nextBidPrice;
    if (serviceTimeSloat != null) {
      data['serviceTimeSloat'] = serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    if (productAvailability != null) {
      data['productAvailability'] = productAvailability!.toJson();
    }
    return data;
  }
}

class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
  dynamic profileImg;
  dynamic bannerImg;

  Storemeta({this.firstName, this.lastName, this.storeId, this.profileImg, this.bannerImg});

  Storemeta.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeId = json['store_id'];
    profileImg = json['profile_img'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['store_id'] = storeId;
    data['profile_img'] = profileImg;
    data['banner_img'] = bannerImg;
    return data;
  }
}

class ServiceTimeSloat {
  dynamic timeSloat;
  dynamic timeSloatEnd;

  ServiceTimeSloat({this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}

class ProductAvailability {
  dynamic qty;
  dynamic type;
  dynamic fromDate;
  dynamic toDate;

  ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }
}

class PromotionData {
  String? promotionLevel;
  String? promotionType;
  int? productStoreId;
  String? banner;

  PromotionData({this.promotionLevel, this.promotionType, this.productStoreId, this.banner});

  PromotionData.fromJson(Map<String, dynamic> json) {
    promotionLevel = json['promotion_level'];
    promotionType = json['promotion_type'];
    productStoreId = json['product_store_id'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotion_level'] = promotionLevel;
    data['promotion_type'] = promotionType;
    data['product_store_id'] = productStoreId;
    data['banner'] = banner;
    return data;
  }
}
