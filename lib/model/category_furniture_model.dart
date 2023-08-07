class CategoryFurnitureModel {
  bool? status;
  String? message;
  List<User>? user;
  String? categoryName;
  List<Product>? product;

  CategoryFurnitureModel(
      {this.status, this.message, this.user, this.categoryName, this.product});

  CategoryFurnitureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(new User.fromJson(v));
      });
    }
    categoryName = json['category_name'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.map((v) => v.toJson()).toList();
    }
    data['category_name'] = this.categoryName;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? storeLogo;
  String? storeImage;
  String? storeName;
  String? email;
  int? storePhone;
  String? description;

  User(
      {this.id,
        this.storeLogo,
        this.storeImage,
        this.storeName,
        this.email,
        this.storePhone,
        this.description});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storeName = json['store_name'];
    email = json['email'];
    storePhone = json['store_phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_logo'] = this.storeLogo;
    data['store_image'] = this.storeImage;
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['store_phone'] = this.storePhone;
    data['description'] = this.description;
    return data;
  }
}

class Product {
  int? id;
  int? vendorId;
  int? catId;
  int? catId2;
  int? catId3;
  String? brandSlug;
  String? slug;
  String? pname;
  Null? prodectImage;
  Null? prodectName;
  Null? prodectSku;
  Null? code;
  Null? bookingProductType;
  Null? prodectPrice;
  Null? prodectMinQty;
  Null? prodectMixQty;
  Null? prodectDescription;
  String? image;
  Null? arabPname;
  String? productType;
  String? skuId;
  int? pPrice;
  int? sPrice;
  Null? commission;
  int? bestSaller;
  int? featured;
  String? taxApply;
  Null? taxType;
  String? shortDescription;
  Null? arabShortDescription;
  String? longDescription;
  Null? arabLongDescription;
  String? featuredImage;
  List<String>? galleryImage;
  String? virtualProductFile;
  String? virtualProductFileType;
  String? inStock;
  String? stockAlert;
  Null? shippingType;
  Null? shippingCharge;
  int? avgRating;
  String? metaTitle;
  String? metaKeyword;
  String? metaDescription;
  int? parentId;
  String? serviceStartTime;
  String? serviceEndTime;
  int? serviceDuration;
  String? createdAt;
  String? updatedAt;
  int? topHunderd;
  String? returnDays;
  int? isPublish;
  int? inOffer;
  String? forAuction;
  String? returnPolicyDesc;
  bool? inCart;
  Null? quantity;
  bool? inWishlist;
  String? currencySign;
  String? currencyCode;
  Storemeta? storemeta;
  bool? allowBid;
  int? nextBidPrice;
  List<Null>? attributes;
  List<Null>? variants;
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
        this.quantity,
        this.inWishlist,
        this.currencySign,
        this.currencyCode,
        this.storemeta,
        this.allowBid,
        this.nextBidPrice,
        this.attributes,
        this.variants,
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
    quantity = json['quantity'];
    inWishlist = json['in_wishlist'];
    currencySign = json['currency_sign'];
    currencyCode = json['currency_code'];
    storemeta = json['storemeta'] != null
        ? new Storemeta.fromJson(json['storemeta'])
        : null;
    allowBid = json['allow_bid'];
    nextBidPrice = json['next_bid_price'];
    if (json['attributes'] != null) {
      attributes = <Null>[];

    }
    if (json['variants'] != null) {
      variants = <Null>[];

    }
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(new ServiceTimeSloat.fromJson(v));
      });
    }
    productAvailability = json['productAvailability'] != null
        ? new ProductAvailability.fromJson(json['productAvailability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['cat_id'] = this.catId;
    data['cat_id_2'] = this.catId2;
    data['cat_id_3'] = this.catId3;
    data['brand_slug'] = this.brandSlug;
    data['slug'] = this.slug;
    data['pname'] = this.pname;
    data['prodect_image'] = this.prodectImage;
    data['prodect_name'] = this.prodectName;
    data['prodect_sku'] = this.prodectSku;
    data['code'] = this.code;
    data['booking_product_type'] = this.bookingProductType;
    data['prodect_price'] = this.prodectPrice;
    data['prodect_min_qty'] = this.prodectMinQty;
    data['prodect_mix_qty'] = this.prodectMixQty;
    data['prodect_description'] = this.prodectDescription;
    data['image'] = this.image;
    data['arab_pname'] = this.arabPname;
    data['product_type'] = this.productType;
    data['sku_id'] = this.skuId;
    data['p_price'] = this.pPrice;
    data['s_price'] = this.sPrice;
    data['commission'] = this.commission;
    data['best_saller'] = this.bestSaller;
    data['featured'] = this.featured;
    data['tax_apply'] = this.taxApply;
    data['tax_type'] = this.taxType;
    data['short_description'] = this.shortDescription;
    data['arab_short_description'] = this.arabShortDescription;
    data['long_description'] = this.longDescription;
    data['arab_long_description'] = this.arabLongDescription;
    data['featured_image'] = this.featuredImage;
    data['gallery_image'] = this.galleryImage;
    data['virtual_product_file'] = this.virtualProductFile;
    data['virtual_product_file_type'] = this.virtualProductFileType;
    data['in_stock'] = this.inStock;
    data['stock_alert'] = this.stockAlert;
    data['shipping_type'] = this.shippingType;
    data['shipping_charge'] = this.shippingCharge;
    data['avg_rating'] = this.avgRating;
    data['meta_title'] = this.metaTitle;
    data['meta_keyword'] = this.metaKeyword;
    data['meta_description'] = this.metaDescription;
    data['parent_id'] = this.parentId;
    data['service_start_time'] = this.serviceStartTime;
    data['service_end_time'] = this.serviceEndTime;
    data['service_duration'] = this.serviceDuration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['top_hunderd'] = this.topHunderd;
    data['return_days'] = this.returnDays;
    data['is_publish'] = this.isPublish;
    data['in_offer'] = this.inOffer;
    data['for_auction'] = this.forAuction;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['in_cart'] = this.inCart;
    data['quantity'] = this.quantity;
    data['in_wishlist'] = this.inWishlist;
    data['currency_sign'] = this.currencySign;
    data['currency_code'] = this.currencyCode;
    if (this.storemeta != null) {
      data['storemeta'] = this.storemeta!.toJson();
    }
    data['allow_bid'] = this.allowBid;
    data['next_bid_price'] = this.nextBidPrice;

    if (this.serviceTimeSloat != null) {
      data['serviceTimeSloat'] =
          this.serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    if (this.productAvailability != null) {
      data['productAvailability'] = this.productAvailability!.toJson();
    }
    return data;
  }
}

class Storemeta {
  String? firstName;
  String? lastName;
  int? storeId;
  String? profileImg;
  String? bannerImg;

  Storemeta(
      {this.firstName,
        this.lastName,
        this.storeId,
        this.profileImg,
        this.bannerImg});

  Storemeta.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeId = json['store_id'];
    profileImg = json['profile_img'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['store_id'] = this.storeId;
    data['profile_img'] = this.profileImg;
    data['banner_img'] = this.bannerImg;
    return data;
  }
}

class ServiceTimeSloat {
  String? timeSloat;
  String? timeSloatEnd;

  ServiceTimeSloat({this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_sloat'] = this.timeSloat;
    data['time_sloat_end'] = this.timeSloatEnd;
    return data;
  }
}

class ProductAvailability {
  int? qty;
  String? type;
  String? fromDate;
  String? toDate;

  ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['type'] = this.type;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}
