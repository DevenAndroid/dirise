class CategoryLibraryModel {
  bool? status;
  String? message;
  // List<Null>? user;
  String? categoryName;
  List<Product>? product;

  CategoryLibraryModel(
      {this.status, this.message, this.categoryName, this.product});

  CategoryLibraryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    categoryName = json['category_name'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['category_name'] = categoryName;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  int? vendorId;
  int? catId;
  // Null? catId2;
  // Null? catId3;
  String? brandSlug;
  String? slug;
  String? pname;
  // Null? prodectImage;
  // Null? prodectName;
  String? prodectSku;
  // Null? code;
  String? bookingProductType;
  // Null? prodectPrice;
  // Null? prodectMinQty;
  // Null? prodectMixQty;
  // Null? prodectDescription;
  String? image;
  // Null? arabPname;
  String? productType;
  String? skuId;
  int? pPrice;
  int? sPrice;
  int? commission;
  int? bestSaller;
  int? featured;
  String? taxApply;
  // Null? taxType;
  String? shortDescription;
  // Null? arabShortDescription;
  String? longDescription;
  // Null? arabLongDescription;
  String? featuredImage;
  // List<Null>? galleryImage;
  String? virtualProductFile;
  String? virtualProductFileType;
  String? inStock;
  String? stockAlert;
  // Null? shippingType;
  // Null? shippingCharge;
  int? avgRating;
  // Null? metaTitle;
  // Null? metaKeyword;
  // Null? metaDescription;
  int? parentId;
  // Null? serviceStartTime;
  // Null? serviceEndTime;
  // Null? serviceDuration;
  String? createdAt;
  String? updatedAt;
  int? topHunderd;
  String? returnDays;
  int? isPublish;
  int? inOffer;
  String? forAuction;
  String? returnPolicyDesc;
  bool? inCart;
  // Null? quantity;
  bool? inWishlist;
  String? currencySign;
  String? currencyCode;
  Storemeta? storemeta;
  bool? allowBid;
  int? nextBidPrice;
  // List<Null>? attributes;
  // List<Null>? variants;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;

  Product(
      {this.id,
        this.vendorId,
        this.catId,
        this.brandSlug,
        this.slug,
        this.pname,
        this.prodectSku,
        this.bookingProductType,
        this.image,
        this.productType,
        this.skuId,
        this.pPrice,
        this.sPrice,
        this.commission,
        this.bestSaller,
        this.featured,
        this.taxApply,
        this.shortDescription,
        this.longDescription,
        this.featuredImage,
        this.virtualProductFile,
        this.virtualProductFileType,
        this.inStock,
        this.stockAlert,
        this.avgRating,
        this.parentId,
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
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    prodectSku = json['prodect_sku'];
    bookingProductType = json['booking_product_type'];
    image = json['image'];
    productType = json['product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    commission = json['commission'];
    bestSaller = json['best_saller'];
    featured = json['featured'];
    taxApply = json['tax_apply'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    inStock = json['in_stock'];
    stockAlert = json['stock_alert'];
    avgRating = json['avg_rating'];
    parentId = json['parent_id'];
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
    storemeta = json['storemeta'] != null
        ? Storemeta.fromJson(json['storemeta'])
        : null;
    allowBid = json['allow_bid'];
    nextBidPrice = json['next_bid_price'];
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(ServiceTimeSloat.fromJson(v));
      });
    }
    productAvailability = json['productAvailability'] != null
        ? ProductAvailability.fromJson(json['productAvailability'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['brand_slug'] = brandSlug;
    data['slug'] = slug;
    data['pname'] = pname;
    data['prodect_sku'] = prodectSku;
    data['booking_product_type'] = bookingProductType;
    data['image'] = image;
    data['product_type'] = productType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['commission'] = commission;
    data['best_saller'] = bestSaller;
    data['featured'] = featured;
    data['tax_apply'] = taxApply;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['featured_image'] = featuredImage;

    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['in_stock'] = inStock;
    data['stock_alert'] = stockAlert;
    data['avg_rating'] = avgRating;
    data['parent_id'] = parentId;
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
      data['serviceTimeSloat'] =
          serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    if (productAvailability != null) {
      data['productAvailability'] = productAvailability!.toJson();
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
  String? timeSloat;
  String? timeSloatEnd;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }
}