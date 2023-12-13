class ModelSingleVendor {
  bool? status;
  dynamic message;
  User? user;
  int? productCount;
  ModelSingleVendor({this.status, this.message, this.user,this.productCount});

  ModelSingleVendor.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['product_count'] = this.productCount;
    return data;
  }
}

class User {
  dynamic id;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic storeName;
  dynamic email;
  dynamic storePhone;
  dynamic description;
  dynamic start;
  dynamic day;
  dynamic end;

  User(
      {this.id,
        this.storeLogo,
        this.storeImage,
        this.storeName,
        this.email,
        this.storePhone,
        this.day,
        this.start,
        this.end,
        this.description});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storeName = json['store_name'];
    email = json['email'];
    storePhone = json['store_phone'];
    description = json['description'];
    day = json['day'];
    start = json['start'];
    end = json['end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_name'] = storeName;
    data['email'] = email;
    data['store_phone'] = storePhone;
    data['day'] = this.day;
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = description;
    return data;
  }
}
