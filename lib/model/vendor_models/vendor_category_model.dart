class ModelVendorCategory {
  bool? status;
  String? message;
  List<Usphone>? usphone = [];

  ModelVendorCategory({this.status, this.message, this.usphone});

  ModelVendorCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['usphone'] != null) {
      usphone = <Usphone>[];
      json['usphone'].forEach((v) {
        usphone!.add(Usphone.fromJson(v));
      });
    } else {
      usphone = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (usphone != null) {
      data['usphone'] = usphone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Usphone {
  int? id;
  String? name;
  String? status;
  String? description;
  String? profileImage;
  String? bannerProfile;
  String? createdAt;
  String? updatedAt;

  Usphone(
      {this.id,
        this.name,
        this.status,
        this.description,
        this.profileImage,
        this.bannerProfile,
        this.createdAt,
        this.updatedAt});

  Usphone.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['description'] = description;
    data['profile_image'] = profileImage;
    data['banner_profile'] = bannerProfile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}