class VendorCategoryModel {
  bool? status;
  String? message;
  List<Data>? data;

  VendorCategoryModel({this.status, this.message, this.data});

  VendorCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? status;
  String? description;
  String? profileImage;
  String? bannerProfile;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.name,
        this.status,
        this.description,
        this.profileImage,
        this.bannerProfile,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    profileImage = json['profile_image'];
    bannerProfile = json['banner_profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['description'] = this.description;
    data['profile_image'] = this.profileImage;
    data['banner_profile'] = this.bannerProfile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
