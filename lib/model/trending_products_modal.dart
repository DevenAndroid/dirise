// To parse this JSON data, do
//
//     final tendingModel = tendingModelFromJson(jsonString);

import 'dart:convert';

TendingModel tendingModelFromJson(String str) => TendingModel.fromJson(json.decode(str));

String tendingModelToJson(TendingModel data) => json.encode(data.toJson());

class TendingModel {
  bool? status;
  dynamic message;
  TendingModelProduct? product;

  TendingModel({
    this.status,
    this.message,
    this.product,
  });

  factory TendingModel.fromJson(Map<String, dynamic> json) => TendingModel(
        status: json["status"],
        message: json["message"],
        product: json["product"] == null ? null : TendingModelProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product": product?.toJson(),
      };
}

class TendingModelProduct {
  dynamic url;
  List<ProductElement>? product;

  TendingModelProduct({
    this.url,
    this.product,
  });

  factory TendingModelProduct.fromJson(Map<String, dynamic> json) => TendingModelProduct(
        url: json["url"],
        product: json["product"] == null
            ? []
            : List<ProductElement>.from(json["product"]!.map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}

class ProductElement {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic catId2;
  dynamic catId3;
  dynamic brandSlug;
  dynamic slug;
  dynamic pname;
  dynamic arabPname;
  dynamic productType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic productNew;
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
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic topHunderd;
  dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic returnPolicyDesc;
  dynamic discountPercentage;
  bool? inCart;
  bool? inWishlist;
  dynamic startDate;
  dynamic endDate;
  dynamic startTime;
  dynamic endTime;
  dynamic minBidPrice;
  dynamic stepPrice;
  dynamic currentBid;
  List<dynamic>? attributes;
  List<dynamic>? variants;
  dynamic bidStatus;

  ProductElement({
    this.id,
    this.vendorId,
    this.catId,
    this.catId2,
    this.catId3,
    this.brandSlug,
    this.slug,
    this.pname,
    this.arabPname,
    this.productType,
    this.skuId,
    this.pPrice,
    this.sPrice,
    this.commission,
    this.productNew,
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
    this.discountPercentage,
    this.inCart,
    this.inWishlist,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.minBidPrice,
    this.stepPrice,
    this.currentBid,
    this.attributes,
    this.variants,
    this.bidStatus,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        id: json["id"],
        vendorId: json["vendor_id"],
        catId: json["cat_id"],
        catId2: json["cat_id_2"],
        catId3: json["cat_id_3"],
        brandSlug: json["brand_slug"],
        slug: json["slug"],
        pname: json["pname"],
        arabPname: json["arab_pname"],
        productType: json["product_type"],
        skuId: json["sku_id"],
        pPrice: json["p_price"],
        sPrice: json["s_price"],
        commission: json["commission"],
        productNew: json["new"],
        bestSaller: json["best_saller"],
        featured: json["featured"],
        taxApply: json["tax_apply"],
        taxType: json["tax_type"],
        shortDescription: json["short_description"],
        arabShortDescription: json["arab_short_description"],
        longDescription: json["long_description"],
        arabLongDescription: json["arab_long_description"],
        featuredImage: json["featured_image"],
        galleryImage: json["gallery_image"] == null ? [] : List<String>.from(json["gallery_image"]!.map((x) => x)),
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
        returnDays: json["return_days"],
        isPublish: json["is_publish"],
        inOffer: json["in_offer"],
        forAuction: json["for_auction"],
        returnPolicyDesc: json["return_policy_desc"],
        discountPercentage: json["discount_percentage"],
        inCart: json["in_cart"],
        inWishlist: json["in_wishlist"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        minBidPrice: json["min_bid_price"],
        stepPrice: json["step_price"],
        currentBid: json["current_bid"],
        attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
        bidStatus: json["bid_status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vendor_id": vendorId,
        "cat_id": catId,
        "cat_id_2": catId2,
        "cat_id_3": catId3,
        "brand_slug": brandSlug,
        "slug": slug,
        "pname": pname,
        "arab_pname": arabPname,
        "product_type": productType,
        "sku_id": skuId,
        "p_price": pPrice,
        "s_price": sPrice,
        "commission": commission,
        "new": productNew,
        "best_saller": bestSaller,
        "featured": featured,
        "tax_apply": taxApply,
        "tax_type": taxType,
        "short_description": shortDescription,
        "arab_short_description": arabShortDescription,
        "long_description": longDescription,
        "arab_long_description": arabLongDescription,
        "featured_image": featuredImage,
        "gallery_image": galleryImage == null ? [] : List<dynamic>.from(galleryImage!.map((x) => x)),
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
        "return_days": returnDays,
        "is_publish": isPublish,
        "in_offer": inOffer,
        "for_auction": forAuction,
        "return_policy_desc": returnPolicyDesc,
        "discount_percentage": discountPercentage,
        "in_cart": inCart,
        "in_wishlist": inWishlist,
        "start_date": startDate,
        "end_date": endDate,
        "start_time": startTime,
        "end_time": endTime,
        "min_bid_price": minBidPrice,
        "step_price": stepPrice,
        "current_bid": currentBid,
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
        "bid_status": bidStatus,
      };
}
