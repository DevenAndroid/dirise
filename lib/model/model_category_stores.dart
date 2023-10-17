import 'package:dirise/model/product_model/model_product_element.dart';
import 'package:dirise/model/vendor_models/model_vendor_orders.dart';

class ModelCategoryStores {
  bool? status;
  dynamic message;
  User? user;
  dynamic categoryName;
  dynamic totalPage;
  SocialLinks? socialLinks;
  List<ProductElement>? product = [];
  List<PromotionData>? promotionData = [];

  ModelCategoryStores(
      {this.status, this.message, this.user, this.categoryName, this.promotionData, this.totalPage, this.product,this.socialLinks});

  ModelCategoryStores.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : User(data: []);
    categoryName = json['category_name'];
    totalPage = json['total_page'];
    if (json['product'] != null) {
      product = <ProductElement>[];
      json['product'].forEach((v) {
        product!.add(ProductElement.fromJson(v));
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
    socialLinks = json['social_links'] != null
        ? SocialLinks.fromJson(json['social_links'])
        : null;
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
    if (socialLinks != null) {
      data['social_links'] = this.socialLinks!.toJson();
    }
    return data;
  }
}

class User {
  dynamic currentPage;
  dynamic day;
  dynamic start;
  dynamic end;
  List<VendorStoreData>? data = [];
  List<Links>? links;
  List<VendorAvailability>? vendorAvailability;
  User({
    this.currentPage,
    this.data,
    this.links,
    this.vendorAvailability,
    this.day,this.start,this.end

  });

  User.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    day = json['day'] ?? "";
    start = json['start'] ?? "";
    end = json['end'] ?? "";
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
    if (json['vendor_availability'] != null) {
      vendorAvailability = <VendorAvailability>[];
      json['vendor_availability'].forEach((v) {
        vendorAvailability!.add(new VendorAvailability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['day'] = day;
    data['start'] = start;
    data['end'] = end;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    if (this.vendorAvailability != null) {
      data['vendor_availability'] =
          this.vendorAvailability!.map((v) => v.toJson()).toList();
    }
    return data;

  }
}

class VendorAvailability {
  int? id;
  int? userId;
  int? weekDay;
  String? startTime;
  String? endTime;
  int? status;
  String? createdAt;
  String? updatedAt;

  VendorAvailability(
      {this.id,
        this.userId,
        this.weekDay,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt});

  VendorAvailability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['week_day'] = this.weekDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  dynamic day;
  dynamic start;
  dynamic end;

  VendorStoreData({this.id, this.storeLogo, this.storeImage, this.storeName, this.email, this.storePhone, this.description,this.day,this.start,this.end});

  VendorStoreData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'] ?? "";
    storeImage = json['store_image'] ?? "";
    storeName = json['store_name'] ?? "Store $id";
    email = json['email'] ?? "";
    storePhone = json['store_phone'] ?? "";
    description = json['description'] ?? "";
    day = json['day'] ?? "";
    start = json['start'] ?? "";
    end = json['end'] ?? "";
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
    data['day'] = day;
    data['start'] = start;
    data['end'] = end;
    return data;
  }
}

class SocialLinks {
  dynamic instagram;
  dynamic facebook;
  dynamic youtube;
  dynamic twitter;
  dynamic pinterest;
  dynamic linkedin;
  dynamic snapchat;
  dynamic tiktok;
  dynamic threads;

  SocialLinks(
      {this.instagram,
        this.facebook,
        this.youtube,
        this.twitter,
        this.pinterest,
        this.linkedin,
        this.snapchat,
        this.tiktok,
        this.threads});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    instagram = json['instagram'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    pinterest = json['pinterest'];
    linkedin = json['linkedin'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    threads = json['threads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['youtube'] = youtube;
    data['twitter'] = twitter;
    data['pinterest'] = pinterest;
    data['linkedin'] = linkedin;
    data['snapchat'] = snapchat;
    data['tiktok'] = tiktok;
    data['threads'] = threads;
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
