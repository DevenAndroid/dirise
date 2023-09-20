import 'package:dirise/model/product_model/model_product_element.dart';

class ModelCategoryStores {
  bool? status;
  dynamic message;
  User? user;
  dynamic categoryName;
  dynamic totalPage;
  List<ProductElement>? product = [];
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
