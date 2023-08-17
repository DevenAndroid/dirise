// To parse this JSON data, do
//
//     final modelCartResponse = modelCartResponseFromJson(jsonString);

import 'dart:convert';

import 'package:dirise/utils/helper.dart';
import 'package:get/get.dart';

ModelCartResponse modelCartResponseFromJson(String str) => ModelCartResponse.fromJson(json.decode(str));

String modelCartResponseToJson(ModelCartResponse data) => json.encode(data.toJson());

class ModelCartResponse {
  bool? status;
  dynamic message;
  dynamic subtotal;
  dynamic shipping;
  dynamic total;
  dynamic discount;
  List<Cart>? cart = [];

  ModelCartResponse({
    this.status,
    this.message,
    this.subtotal,
    this.shipping,
    this.total,
    this.discount,
    this.cart,
  });
  num get totalQuantity {
    return cart != null ? cart!.map((e) => e.qty.toString().convertToNum ?? 0).toList().getTotal : 0;
  }
  // num get totalQuantity {
  //   return cart != null ? cart!.map((e) => e.qty.toString().convertToNum ?? 0).toList().getTotal : 0;
  // }

  factory ModelCartResponse.fromJson(Map<String, dynamic> json) => ModelCartResponse(
        status: json["status"],
        message: json["message"],
        subtotal: json["subtotal"],
        shipping: json["shipping"],
        total: json["total"],
        discount: json["discount"],
        cart: json["cart"] == null ? [] : List<Cart>.from(json["cart"]!.map((x) => Cart.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "subtotal": subtotal,
        "shipping": shipping,
        "total": total,
        "discount": discount,
        "cart": cart == null ? [] : List<dynamic>.from(cart!.map((x) => x.toJson())),
      };
}

class Cart {
  dynamic id;
  dynamic selectedSlotStart;
  dynamic selectedSlotEnd;
  dynamic selectedSlotDate;
  RxBool showDetails = false.obs;
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
  // dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic cartNew;
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
  dynamic cartId;
  dynamic qty;
  bool? inCart;
  bool? inWishlist;
  dynamic currencySign;
  dynamic currencyCode;
  List<dynamic>? attributes;
  List<dynamic>? variants;
  dynamic buyAvailable;
  dynamic bidPrice;
  dynamic startDate;
  dynamic endDate;
  dynamic startTime;
  dynamic endTime;
  dynamic minBidPrice;
  dynamic stepPrice;
  dynamic currentBid;

  Cart({
    this.id,
    this.selectedSlotStart,
    this.selectedSlotEnd,
    this.selectedSlotDate,
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
    // this.pPrice,
    this.sPrice,
    this.commission,
    this.cartNew,
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
    this.cartId,
    this.qty,
    this.inCart,
    this.inWishlist,
    this.currencySign,
    this.currencyCode,
    this.attributes,
    this.variants,
    this.buyAvailable,
    this.bidPrice,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.minBidPrice,
    this.stepPrice,
    this.currentBid,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json["id"],
        selectedSlotStart: json["selected_sloat_start"],
        selectedSlotEnd: json["selected_sloat_end"],
        selectedSlotDate: json["selected_sloat_date"],
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
        // pPrice: json["p_price"],
        sPrice: json["s_price"],
        commission: json["commission"],
        cartNew: json["new"],
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
        cartId: json["cart_id"],
        qty: json["qty"],
        inCart: json["in_cart"],
        inWishlist: json["in_wishlist"],
        currencySign: json["currency_sign"],
        currencyCode: json["currency_code"],
        attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
        buyAvailable: json["buy_available"],
        bidPrice: json["bid_price"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        minBidPrice: json["min_bid_price"],
        stepPrice: json["step_price"],
        currentBid: json["current_bid"],
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
        // "p_price": pPrice,
        "s_price": sPrice,
        "commission": commission,
        "new": cartNew,
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
        "cart_id": cartId,
        "qty": qty,
        "in_cart": inCart,
        "in_wishlist": inWishlist,
        "currency_sign": currencySign,
        "currency_code": currencyCode,
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
        "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
        "buy_available": buyAvailable,
        "bid_price": bidPrice,
        "start_date": startDate,
        "end_date": endDate,
        "start_time": startTime,
        "end_time": endTime,
        "min_bid_price": minBidPrice,
        "step_price": stepPrice,
        "current_bid": currentBid,
      };
}
