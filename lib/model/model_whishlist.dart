class WhishlistModel {
  bool? status;
  String? message;
  List<Null>? wishlist;

  WhishlistModel({this.status, this.message, this.wishlist});

  WhishlistModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['wishlist'] != null) {
      wishlist = <Null>[];
      // json['wishlist'].forEach((v) {
      //   wishlist!.add(new Null.fromJson(v));
      // });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.wishlist != null) {
      // data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
