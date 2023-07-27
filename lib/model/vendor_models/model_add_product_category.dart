import 'package:get/get.dart';

class ModelAddProductCategory {
  bool? status;
  dynamic message;
  List<ProdectCategoryData>? prodect = [];

  ModelAddProductCategory({this.status, this.message, this.prodect});

  ModelAddProductCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['prodect'] != null) {
      prodect = <ProdectCategoryData>[];
      json['prodect'].forEach((v) {
        prodect!.add(ProdectCategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (prodect != null) {
      data['prodect'] = prodect!.map((v) => v.toJson()).toList();
    } else {
      prodect = [];
    }
    return data;
  }
}

class ProdectCategoryData {
  dynamic id;
  dynamic vendorId;
  dynamic parentId;
  dynamic level;
  dynamic commision;
  dynamic categoryImage;
  dynamic categoryImageBanner;
  dynamic discription;
  dynamic arabDescription;
  dynamic status;
  dynamic title;
  dynamic arabTitle;
  dynamic slug;
  dynamic createdAt;
  dynamic updatedAt;

  ProdectCategoryData(
      {this.id,
        this.vendorId,
        this.parentId,
        this.level,
        this.commision,
        this.categoryImage,
        this.categoryImageBanner,
        this.discription,
        this.arabDescription,
        this.status,
        this.title,
        this.arabTitle,
        this.slug,
        this.createdAt,
        this.updatedAt});

  ProdectCategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    parentId = json['parent_id'];
    level = json['level'];
    commision = json['commision'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
    discription = json['discription'];
    arabDescription = json['arab_description'];
    status = json['status'];
    title = json['title'];
    arabTitle = json['arab_title'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['parent_id'] = parentId;
    data['level'] = level;
    data['commision'] = commision;
    data['category_image'] = categoryImage;
    data['category_image_banner'] = categoryImageBanner;
    data['discription'] = discription;
    data['arab_description'] = arabDescription;
    data['status'] = status;
    data['title'] = title;
    data['arab_title'] = arabTitle;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
