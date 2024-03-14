class ModelNewsTrends {
  bool? status;
  dynamic message;
  List<Data>? data;

  ModelNewsTrends({this.status, this.message, this.data});

  ModelNewsTrends.fromJson(Map<String, dynamic> json) {
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
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic title;
  dynamic discription;
  dynamic file;
  dynamic fileType;
  dynamic thumbnail;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.discription,
        this.file,
        this.fileType,
        this.thumbnail,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    discription = json['discription'];
    file = json['file'];
    fileType = json['file_type'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['discription'] = discription;
    data['file'] = file;
    data['file_type'] = fileType;
    data['thumbnail'] = thumbnail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
