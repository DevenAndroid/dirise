

import 'dart:convert';

class WhishlistModel {
  bool? status;
  String? message;
  List<Wishlist>? wishlist;

  WhishlistModel({
    this.status,
    this.message,
    this.wishlist,
  });

  factory WhishlistModel.fromRawJson(String str) => WhishlistModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WhishlistModel.fromJson(Map<String, dynamic> json) => WhishlistModel(
    status: json["status"],
    message: json["message"],
    wishlist: json["wishlist"] == null ? [] : List<Wishlist>.from(json["wishlist"]!.map((x) => Wishlist.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "wishlist": wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
  };
}

class Wishlist {
  int? id;
  int? vendorId;
  int? catId;
  int? catId2;
  int? catId3;
  BrandSlug? brandSlug;
  String? slug;
  String? pname;
  dynamic prodectImage;
  dynamic prodectName;
  dynamic prodectSku;
  int? code;
  dynamic prodectPrice;
  dynamic prodectMinQty;
  dynamic prodectMixQty;
  dynamic prodectDescription;
  String? prodectPdfFile;
  dynamic prodectVoice;
  String? image;
  dynamic arabPname;
  ProductType? productType;
  String? skuId;
  int? pPrice;
  int? sPrice;
  dynamic commission;
  int? wishlistNew;
  int? bestSaller;
  int? featured;
  TaxApply? taxApply;
  dynamic taxType;
  String? shortDescription;
  dynamic arabShortDescription;
  String? longDescription;
  dynamic arabLongDescription;
  String? featuredImage;
  List<String>? galleryImage;
  dynamic video;
  String? inStock;
  String? stockAlert;
  dynamic shippingType;
  dynamic shippingCharge;
  int? avgRating;
  String? metaTitle;
  String? metaKeyword;
  String? metaDescription;
  int? parentId;
  String? serviceStartTime;
  String? serviceEndTime;
  int? serviceDuration;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? topHunderd;
  ReturnDays? returnDays;
  int? isPublish;
  int? inOffer;
  ForAuction? forAuction;
  String? returnPolicyDesc;
  dynamic bidingPrice;
  bool? inCart;
  bool? inWishlist;
  CurrencySign? currencySign;
  CurrencyCode? currencyCode;
  List<dynamic>? attributes;
  List<dynamic>? variants;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  dynamic minBidPrice;
  dynamic stepPrice;
  dynamic currentBid;
  String? bidStatus;

  Wishlist({
    this.id,
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
    this.prodectPrice,
    this.prodectMinQty,
    this.prodectMixQty,
    this.prodectDescription,
    this.prodectPdfFile,
    this.prodectVoice,
    this.image,
    this.arabPname,
    this.productType,
    this.skuId,
    this.pPrice,
    this.sPrice,
    this.commission,
    this.wishlistNew,
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
    this.video,
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
    this.bidingPrice,
    this.inCart,
    this.inWishlist,
    this.currencySign,
    this.currencyCode,
    this.attributes,
    this.variants,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.minBidPrice,
    this.stepPrice,
    this.currentBid,
    this.bidStatus,
  });

  factory Wishlist.fromRawJson(String str) => Wishlist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
    id: json["id"],
    vendorId: json["vendor_id"],
    catId: json["cat_id"],
    catId2: json["cat_id_2"],
    catId3: json["cat_id_3"],
    brandSlug: brandSlugValues.map[json["brand_slug"]]!,
    slug: json["slug"],
    pname: json["pname"],
    prodectImage: json["prodect_image"],
    prodectName: json["prodect_name"],
    prodectSku: json["prodect_sku"],
    code: json["code"],
    prodectPrice: json["prodect_price"],
    prodectMinQty: json["prodect_min_qty"],
    prodectMixQty: json["prodect_mix_qty"],
    prodectDescription: json["prodect_description"],
    prodectPdfFile: json["prodect_pdf_file"],
    prodectVoice: json["prodect_voice"],
    image: json["image"],
    arabPname: json["arab_pname"],
    productType: productTypeValues.map[json["product_type"]]!,
    skuId: json["sku_id"],
    pPrice: json["p_price"],
    sPrice: json["s_price"],
    commission: json["commission"],
    wishlistNew: json["new"],
    bestSaller: json["best_saller"],
    featured: json["featured"],
    taxApply: taxApplyValues.map[json["tax_apply"]]!,
    taxType: json["tax_type"],
    shortDescription: json["short_description"],
    arabShortDescription: json["arab_short_description"],
    longDescription: json["long_description"],
    arabLongDescription: json["arab_long_description"],
    featuredImage: json["featured_image"],
    galleryImage: json["gallery_image"] == null ? [] : List<String>.from(json["gallery_image"]!.map((x) => x)),
    video: json["video"],
    inStock: json["in_stock"],
    stockAlert: json["stock_alert"],
    shippingType: json["shipping_type"],
    shippingCharge: json["shipping_charge"],
    avgRating: json["avg_rating"],
    metaTitle: json["meta_title"],
    metaKeyword: json["meta_keyword"],
    metaDescription: json["meta_description"],
    parentId: json["parent_id"],
    serviceStartTime: json["service_start_time"],
    serviceEndTime: json["service_end_time"],
    serviceDuration: json["service_duration"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    topHunderd: json["top_hunderd"],
    returnDays: returnDaysValues.map[json["return_days"]]!,
    isPublish: json["is_publish"],
    inOffer: json["in_offer"],
    forAuction: forAuctionValues.map[json["for_auction"]]!,
    returnPolicyDesc: json["return_policy_desc"],
    bidingPrice: json["biding_price"],
    inCart: json["in_cart"],
    inWishlist: json["in_wishlist"],
    currencySign: currencySignValues.map[json["currency_sign"]]!,
    currencyCode: currencyCodeValues.map[json["currency_code"]]!,
    attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    startDate: json["start_date"],
    endDate: json["end_date"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    minBidPrice: json["min_bid_price"],
    stepPrice: json["step_price"],
    currentBid: json["current_bid"],
    bidStatus: json["bid_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "cat_id": catId,
    "cat_id_2": catId2,
    "cat_id_3": catId3,
    "brand_slug": brandSlugValues.reverse[brandSlug],
    "slug": slug,
    "pname": pname,
    "prodect_image": prodectImage,
    "prodect_name": prodectName,
    "prodect_sku": prodectSku,
    "code": code,
    "prodect_price": prodectPrice,
    "prodect_min_qty": prodectMinQty,
    "prodect_mix_qty": prodectMixQty,
    "prodect_description": prodectDescription,
    "prodect_pdf_file": prodectPdfFile,
    "prodect_voice": prodectVoice,
    "image": image,
    "arab_pname": arabPname,
    "product_type": productTypeValues.reverse[productType],
    "sku_id": skuId,
    "p_price": pPrice,
    "s_price": sPrice,
    "commission": commission,
    "new": wishlistNew,
    "best_saller": bestSaller,
    "featured": featured,
    "tax_apply": taxApplyValues.reverse[taxApply],
    "tax_type": taxType,
    "short_description": shortDescription,
    "arab_short_description": arabShortDescription,
    "long_description": longDescription,
    "arab_long_description": arabLongDescription,
    "featured_image": featuredImage,
    "gallery_image": galleryImage == null ? [] : List<dynamic>.from(galleryImage!.map((x) => x)),
    "video": video,
    "in_stock": inStock,
    "stock_alert": stockAlert,
    "shipping_type": shippingType,
    "shipping_charge": shippingCharge,
    "avg_rating": avgRating,
    "meta_title": metaTitle,
    "meta_keyword": metaKeyword,
    "meta_description": metaDescription,
    "parent_id": parentId,
    "service_start_time": serviceStartTime,
    "service_end_time": serviceEndTime,
    "service_duration": serviceDuration,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "top_hunderd": topHunderd,
    "return_days": returnDaysValues.reverse[returnDays],
    "is_publish": isPublish,
    "in_offer": inOffer,
    "for_auction": forAuctionValues.reverse[forAuction],
    "return_policy_desc": returnPolicyDesc,
    "biding_price": bidingPrice,
    "in_cart": inCart,
    "in_wishlist": inWishlist,
    "currency_sign": currencySignValues.reverse[currencySign],
    "currency_code": currencyCodeValues.reverse[currencyCode],
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "start_date": startDate,
    "end_date": endDate,
    "start_time": startTime,
    "end_time": endTime,
    "min_bid_price": minBidPrice,
    "step_price": stepPrice,
    "current_bid": currentBid,
    "bid_status": bidStatus,
  };
}

enum BrandSlug { TEST, APPLE, SAMSUNG }

final brandSlugValues = EnumValues({
  "apple": BrandSlug.APPLE,
  "samsung": BrandSlug.SAMSUNG,
  "test": BrandSlug.TEST
});

enum CurrencyCode { USD }

final currencyCodeValues = EnumValues({
  "USD": CurrencyCode.USD
});

enum CurrencySign { EMPTY }

final currencySignValues = EnumValues({
  "\u0024": CurrencySign.EMPTY
});

enum ForAuction { OFF, ON }

final forAuctionValues = EnumValues({
  "off": ForAuction.OFF,
  "on": ForAuction.ON
});

enum ProductType { SINGLE, BID, BOOKING }

final productTypeValues = EnumValues({
  "bid": ProductType.BID,
  "booking": ProductType.BOOKING,
  "single": ProductType.SINGLE
});

enum ReturnDays { NONE }

final returnDaysValues = EnumValues({
  "none": ReturnDays.NONE
});

enum TaxApply { EXCLUDE, INCLUDE }

final taxApplyValues = EnumValues({
  "exclude": TaxApply.EXCLUDE,
  "include": TaxApply.INCLUDE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
