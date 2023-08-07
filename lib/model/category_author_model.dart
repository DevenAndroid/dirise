class CategoryAuthorsModel {
  bool? status;
  String? message;
  List<User>? user;
  String? categoryName;
  List<Product>? product;

  CategoryAuthorsModel({this.status, this.message, this.user, this.categoryName, this.product});

  CategoryAuthorsModel.fromJson(Map<String, dynamic> json) {
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

  User({this.id, this.storeLogo, this.storeImage, this.storeName, this.email, this.storePhone, this.description});

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
  // Null? catId2;
  // Null? catId3;
  String? brandSlug;
  String? slug;
  String? pname;
  // Null? prodectImage;
  // Null? prodectName;
  // Null? prodectSku;
  // Null? code;
  // Null? bookingProductType;
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
  List<String>? galleryImage;
  String? virtualProductFile;
  // Null? virtualProductFileType;
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

  Product({
    this.id,
    this.vendorId,
    this.catId,
    this.brandSlug,
    this.slug,
    this.pname,
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
    this.storemeta,
    this.allowBid,
    this.nextBidPrice,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
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
    storemeta = json['storemeta'] != null ? new Storemeta.fromJson(json['storemeta']) : null;
    allowBid = json['allow_bid'];
    nextBidPrice = json['next_bid_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['cat_id'] = this.catId;

    data['brand_slug'] = this.brandSlug;
    data['slug'] = this.slug;
    data['pname'] = this.pname;
    data['image'] = this.image;
    data['product_type'] = this.productType;
    data['sku_id'] = this.skuId;
    data['p_price'] = this.pPrice;
    data['s_price'] = this.sPrice;
    data['commission'] = this.commission;
    data['best_saller'] = this.bestSaller;
    data['featured'] = this.featured;
    data['tax_apply'] = this.taxApply;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['featured_image'] = this.featuredImage;
    data['gallery_image'] = this.galleryImage;
    data['virtual_product_file'] = this.virtualProductFile;
    data['in_stock'] = this.inStock;
    data['stock_alert'] = this.stockAlert;
    data['avg_rating'] = this.avgRating;

    data['parent_id'] = this.parentId;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['top_hunderd'] = this.topHunderd;
    data['return_days'] = this.returnDays;
    data['is_publish'] = this.isPublish;
    data['in_offer'] = this.inOffer;
    data['for_auction'] = this.forAuction;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['in_cart'] = this.inCart;
    data['in_wishlist'] = this.inWishlist;
    data['currency_sign'] = this.currencySign;
    data['currency_code'] = this.currencyCode;
    if (this.storemeta != null) {
      data['storemeta'] = this.storemeta!.toJson();
    }
    data['allow_bid'] = this.allowBid;
    data['next_bid_price'] = this.nextBidPrice;
    return data;
  }
}

class Storemeta {
  String? firstName;
  String? lastName;
  int? storeId;
  String? profileImg;
  String? bannerImg;

  Storemeta({this.firstName, this.lastName, this.storeId, this.profileImg, this.bannerImg});

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
