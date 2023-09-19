class ModelSingleProduct {
  bool? status;
  dynamic message;
  Product? product;

  ModelSingleProduct({
    this.status,
    this.message,
    this.product
  });

  ModelSingleProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
    json['product'] != null &&
        json['product'].toString() != "[]" &&
        json['product'].toString().isNotEmpty ?
    Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic brandSlug;
  dynamic slug;
  dynamic pName;
  dynamic bookingProductType;
  dynamic image;
  dynamic productType;
  dynamic virtualProductType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic bestSaller;
  dynamic featured;
  dynamic taxApply;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic virtualProductFile;
  dynamic inStock;
  dynamic stockAlert;
  dynamic avgRating;
  dynamic parentId;
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
  Storemeta? storeMeta;
  bool? allowBid;
  dynamic nextBidPrice;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;
  List<Attributes>? attributes;
  List<Variants>? variants;

  Product(
      {this.id,
        this.vendorId,
        this.catId,
        this.brandSlug,
        this.slug,
        this.pName,
        this.bookingProductType,
        this.image,
        this.productType,
        this.virtualProductType,
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
        this.galleryImage,
        this.virtualProductFile,
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
        this.storeMeta,
        this.allowBid,
        this.nextBidPrice,
        this.serviceTimeSloat,
        this.productAvailability,
        this.attributes,
        this.variants});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pName = json['pname'];
    bookingProductType = json['booking_product_type'];
    image = json['image'];
    productType = json['product_type'];
    virtualProductType = json['virtual_product_type'];
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
    galleryImage = json['gallery_image'].cast<String>();
    virtualProductFile = json['virtual_product_file'];
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
    storeMeta = json['storemeta'] != null ? Storemeta.fromJson(json['storemeta']) : null;
    allowBid = json['allow_bid'];
    nextBidPrice = json['next_bid_price'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(Attributes.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
    if (json['serviceTimeSloat'] != null) {serviceTimeSloat = <ServiceTimeSloat>[];json['serviceTimeSloat'].forEach((v) {serviceTimeSloat!.add(ServiceTimeSloat.fromJson(v));});}
    productAvailability = json['productAvailability'] != null ? ProductAvailability.fromJson(json['productAvailability']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['virtual_product_type'] = virtualProductType;
    data['brand_slug'] = brandSlug;
    data['slug'] = slug;
    data['pname'] = pName;
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
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
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
    if (storeMeta != null) {data['storemeta'] = storeMeta!.toJson();}
    data['allow_bid'] = allowBid;
    data['next_bid_price'] = nextBidPrice;
    if (serviceTimeSloat != null) {data['serviceTimeSloat'] = serviceTimeSloat!.map((v) => v.toJson()).toList();}
    if (productAvailability != null) {data['productAvailability'] = productAvailability!.toJson();

    }
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
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
  dynamic id;
  dynamic timeSloat;
  dynamic timeSloatEnd;

  ServiceTimeSloat({this.id, this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
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

class Attributes {
  dynamic id;
  dynamic name;
  List<String>? values;

  Attributes({this.id, this.name, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['values'] = values;
    return data;
  }
}

class Variants {
  dynamic id;
  dynamic comb;
  dynamic price;
  dynamic image;

  Variants({this.id, this.comb, this.price, this.image});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comb = json['comb'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comb'] = comb;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}