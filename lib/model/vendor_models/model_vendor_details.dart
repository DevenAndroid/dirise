class ModelVendorDetails {
  bool? status;
  String? message;
  User? user;

  ModelVendorDetails({this.status, this.message, this.user});

  ModelVendorDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  String? email;
  dynamic dob;
  dynamic countryCode;
  dynamic phone;
  dynamic storeName;
  dynamic storeBusinessId;
  dynamic storeAboutUs;
  dynamic storeAboutMe;
  dynamic storeAddress;
  String? storeLogo;
  String? storeImage;
  dynamic storePhone;
  dynamic description;
  dynamic categoryId;
  dynamic bio;
  dynamic socialId;
  dynamic apiToken;
  dynamic deviceId;
  dynamic deviceToken;
  dynamic emailVerifiedAt;
  String? newSocialUser;
  String? customerId;
  dynamic defaultCard;
  String? userWallet;
  dynamic isMobileVerified;
  dynamic otpVerified;
  dynamic isApproved;
  dynamic vendorWallet;
  String? profileImage;
  dynamic bannerProfile;
  dynamic categoryImage;
  dynamic address;
  dynamic countryId;
  dynamic stateId;
  dynamic city;
  dynamic streetName;
  dynamic block;
  dynamic stripeId;
  String? currency;
  dynamic storeOn;
  dynamic readyForOrder;
  bool? isVendor;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<Null>? venderCategory;
  List<Roles>? roles;

  User(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.dob,
        this.countryCode,
        this.phone,
        this.storeName,
        this.storeBusinessId,
        this.storeAboutUs,
        this.storeAboutMe,
        this.storeAddress,
        this.storeLogo,
        this.storeImage,
        this.storePhone,
        this.description,
        this.categoryId,
        this.bio,
        this.socialId,
        this.apiToken,
        this.deviceId,
        this.deviceToken,
        this.emailVerifiedAt,
        this.newSocialUser,
        this.customerId,
        this.defaultCard,
        this.userWallet,
        this.isMobileVerified,
        this.otpVerified,
        this.isApproved,
        this.vendorWallet,
        this.profileImage,
        this.bannerProfile,
        this.categoryImage,
        this.address,
        this.countryId,
        this.stateId,
        this.city,
        this.streetName,
        this.block,
        this.stripeId,
        this.currency,
        this.storeOn,
        this.readyForOrder,
        this.isVendor,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.venderCategory,
        this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dob = json['dob'];
    countryCode = json['country_code'];
    phone = json['phone'];
    storeName = json['store_name'];
    storeBusinessId = json['store_business_id'];
    storeAboutUs = json['store_about_us'];
    storeAboutMe = json['store_about_me'];
    storeAddress = json['store_address'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storePhone = json['store_phone'];
    description = json['description'];
    categoryId = json['category_id'];
    bio = json['bio'];
    socialId = json['social_id'];
    apiToken = json['api_token'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    emailVerifiedAt = json['email_verified_at'];
    newSocialUser = json['new_social_user'];
    customerId = json['customer_id'];
    defaultCard = json['default_card'];
    userWallet = json['user_wallet'];
    isMobileVerified = json['is_mobile_verified'];
    otpVerified = json['otp_verified'];
    isApproved = json['is_approved'];
    vendorWallet = json['vendor_wallet'];
    profileImage = json['profile_image'];
    bannerProfile = json['banner_profile'];
    categoryImage = json['category_image'];
    address = json['address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    city = json['city'];
    streetName = json['street_name'];
    block = json['block'];
    stripeId = json['stripe_id'];
    currency = json['currency'];
    storeOn = json['store_on'];
    readyForOrder = json['ready_for_order'];
    isVendor = json['is_vendor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    // if (json['vender_category'] != null) {
    //   venderCategory = <Null>[];
    //   json['vender_category'].forEach((v) {
    //     venderCategory!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['country_code'] = this.countryCode;
    data['phone'] = this.phone;
    data['store_name'] = this.storeName;
    data['store_business_id'] = this.storeBusinessId;
    data['store_about_us'] = this.storeAboutUs;
    data['store_about_me'] = this.storeAboutMe;
    data['store_address'] = this.storeAddress;
    data['store_logo'] = this.storeLogo;
    data['store_image'] = this.storeImage;
    data['store_phone'] = this.storePhone;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['bio'] = this.bio;
    data['social_id'] = this.socialId;
    data['api_token'] = this.apiToken;
    data['device_id'] = this.deviceId;
    data['device_token'] = this.deviceToken;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['new_social_user'] = this.newSocialUser;
    data['customer_id'] = this.customerId;
    data['default_card'] = this.defaultCard;
    data['user_wallet'] = this.userWallet;
    data['is_mobile_verified'] = this.isMobileVerified;
    data['otp_verified'] = this.otpVerified;
    data['is_approved'] = this.isApproved;
    data['vendor_wallet'] = this.vendorWallet;
    data['profile_image'] = this.profileImage;
    data['banner_profile'] = this.bannerProfile;
    data['category_image'] = this.categoryImage;
    data['address'] = this.address;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city'] = this.city;
    data['street_name'] = this.streetName;
    data['block'] = this.block;
    data['stripe_id'] = this.stripeId;
    data['currency'] = this.currency;
    data['store_on'] = this.storeOn;
    data['ready_for_order'] = this.readyForOrder;
    data['is_vendor'] = this.isVendor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    // if (this.venderCategory != null) {
    //   data['vender_category'] =
    //       this.venderCategory!.map((v) => v.toJson()).toList();
    // }
    if (this.roles != null) {
      data['roles'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  dynamic id;
  String? title;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Roles({this.id, this.title, this.createdAt, this.updatedAt, this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  dynamic userId;
  dynamic roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['role_id'] = this.roleId;
    return data;
  }
}
