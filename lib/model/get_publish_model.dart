class GetPublishPostModel {
  bool? status;
  String? message;
  List<Data>? data;

  GetPublishPostModel({this.status, this.message, this.data});

  GetPublishPostModel.fromJson(Map<String, dynamic> json) {
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
  UserId? userId;
  String? title;
  String? discription;
  String? file;
  String? fileType;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.discription,
        this.file,
        this.fileType,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId =
    json['user_id'] != null ? new UserId.fromJson(json['user_id']) : null;
    title = json['title'];
    discription = json['discription'];
    file = json['file'];
    fileType = json['file_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userId != null) {
      data['user_id'] = this.userId!.toJson();
    }
    data['title'] = this.title;
    data['discription'] = this.discription;
    data['file'] = this.file;
    data['file_type'] = this.fileType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class UserId {
  String? name;
  String? profileImage;
  String? email;

  UserId({this.name, this.profileImage, this.email});

  UserId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['email'] = this.email;
    return data;
  }
}
