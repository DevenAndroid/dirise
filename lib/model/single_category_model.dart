class SingleCategoryModel {
  bool? status;
  String? message;
  Data? data;

  SingleCategoryModel({this.status, this.message, this.data});

  SingleCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? sliders;
  List<Stores>? stores;

  Data({this.sliders, this.stores});

  Data.fromJson(Map<String, dynamic> json) {
    sliders = json['sliders'].cast<String>();
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sliders'] = this.sliders;
    if (this.stores != null) {
      data['stores'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  String? businessName;
  String? country;
  String? state;
  String? city;
  String? postcode;
  String? helplineNumber;
  String? email;
  String? panNumber;
  String? gstinNumber;
  String? address;
  String? businessLogo;
  String? cinNumber;
  String? firstName;
  String? lastName;
  String? storeName;
  String? storeRating;
  String? storeUrl;
  String? phoneNumber;
  String? userName;
  String? street1;
  String? street2;
  String? zip;
  String? profileImg;
  String? bannerImg;
  int? vendorId;
  String? commision;
  String? instagram;
  String? youtube;
  String? twitter;
  String? linkedin;
  String? facebook;
  String? pinterest;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? bankNumber;
  String? swiftCode;
  String? routingNumber;
  String? selling;
  String? productPublish;
  String? featureVendor;
  String? notify;
  String? paypalId;
  String? freeShippingIsApplied;
  String? normalShippingIsApplied;
  String? normalPrice;
  String? freeShippingOver;
  String? shippingByCityIsApplied;
  String? sellingArea;

  Stores(
      { this.businessName,
        this.country,
        this.state,
        this.city,
        this.postcode,
        this.helplineNumber,
        this.email,
        this.panNumber,
        this.gstinNumber,
        this.address,
        this.businessLogo,
        this.cinNumber,
        this.firstName,
        this.lastName,
        this.storeName,
        this.storeRating,
        this.storeUrl,
        this.phoneNumber,
        this.userName,
        this.street1,
        this.street2,
        this.zip,
        this.profileImg,
        this.bannerImg,
        this.vendorId,
        this.commision,
        this.instagram,
        this.youtube,
        this.twitter,
        this.linkedin,
        this.facebook,
        this.pinterest,
        this.accountName,
        this.accountNumber,
        this.bankName,
        this.bankNumber,
        this.swiftCode,
        this.routingNumber,
        this.selling,
        this.productPublish,
        this.featureVendor,
        this.notify,
        this.paypalId,
        this.freeShippingIsApplied,
        this.normalShippingIsApplied,
        this.normalPrice,
        this.freeShippingOver,
        this.shippingByCityIsApplied,
        this.sellingArea}

      );

  Stores.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    helplineNumber = json['helpline_number_'];
    email = json['email'];
    panNumber = json['pan_number'];
    gstinNumber = json['gstin_number'];
    address = json['address'];
    businessLogo = json['business_logo'];
    cinNumber = json['cin_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeName = json['store_name'];
    storeRating = json['store_rating'];
    storeUrl = json['store_url'];
    phoneNumber = json['phone_number'];
    userName = json['user_name_'];
    street1 = json['street_1'];
    street2 = json['street_2'];
    zip = json['zip'];
    profileImg = json['profile_img'];
    bannerImg = json['banner_img'];
    vendorId = json['vendor_id'];
    commision = json['commision'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    facebook = json['facebook'];
    pinterest = json['pinterest'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankNumber = json['bank_number'];
    swiftCode = json['swift_code'];
    routingNumber = json['routing_number'];
    selling = json['selling'];
    productPublish = json['product_publish'];
    featureVendor = json['feature_vendor'];
    notify = json['notify'];
    paypalId = json['paypal_id'];
    freeShippingIsApplied = json['free_shipping_is_applied'];
    normalShippingIsApplied = json['normal_shipping_is_applied'];
    normalPrice = json['normal_price'];
    freeShippingOver = json['free_shipping_over'];
    shippingByCityIsApplied = json['shipping_by_city_is_applied'];
    sellingArea = json['selling_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['business_name'] = this.businessName;
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['postcode'] = this.postcode;
    data['helpline_number_'] = this.helplineNumber;
    data['email'] = this.email;
    data['pan_number'] = this.panNumber;
    data['gstin_number'] = this.gstinNumber;
    data['address'] = this.address;
    data['business_logo'] = this.businessLogo;
    data['cin_number'] = this.cinNumber;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['store_name'] = this.storeName;
    data['store_rating'] = this.storeRating;
    data['store_url'] = this.storeUrl;
    data['phone_number'] = this.phoneNumber;
    data['user_name_'] = this.userName;
    data['street_1'] = this.street1;
    data['street_2'] = this.street2;
    data['zip'] = this.zip;
    data['profile_img'] = this.profileImg;
    data['banner_img'] = this.bannerImg;
    data['vendor_id'] = this.vendorId;
    data['commision'] = this.commision;
    data['instagram'] = this.instagram;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['linkedin'] = this.linkedin;
    data['facebook'] = this.facebook;
    data['pinterest'] = this.pinterest;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['bank_name'] = this.bankName;
    data['bank_number'] = this.bankNumber;
    data['swift_code'] = this.swiftCode;
    data['routing_number'] = this.routingNumber;
    data['selling'] = this.selling;
    data['product_publish'] = this.productPublish;
    data['feature_vendor'] = this.featureVendor;
    data['notify'] = this.notify;
    data['paypal_id'] = this.paypalId;
    data['free_shipping_is_applied'] = this.freeShippingIsApplied;
    data['normal_shipping_is_applied'] = this.normalShippingIsApplied;
    data['normal_price'] = this.normalPrice;
    data['free_shipping_over'] = this.freeShippingOver;
    data['shipping_by_city_is_applied'] = this.shippingByCityIsApplied;
    data['selling_area'] = this.sellingArea;
    return data;
  }
}
