import 'package:dirise/model/product_model/model_product_element.dart';

class ModelFilterByPrice {
  bool? status;
  String? message;
  List<ProductElement>? product;

  ModelFilterByPrice({this.status, this.message, this.product});

  ModelFilterByPrice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product'] != null) {
      product = <ProductElement>[];
      json['product'].forEach((v) {
        product!.add(new ProductElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
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
