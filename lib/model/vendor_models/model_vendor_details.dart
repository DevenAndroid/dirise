class ModelVendorDetails {
  bool? status;
  dynamic message;
  VendorUser? user;

  ModelVendorDetails({this.status, this.message, this.user});

  ModelVendorDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? VendorUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class VendorUser {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic dob;
  dynamic countryCode;
  dynamic phone;
  dynamic storeName;
  dynamic storeBusinessId;
  dynamic storeAboutUs;
  dynamic storeAboutMe;
  dynamic storeAddress;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic storePhone;
  dynamic description;
  dynamic categoryId;
  dynamic bio;
  dynamic socialId;
  dynamic apiToken;
  dynamic deviceId;
  dynamic deviceToken;
  dynamic emailVerifiedAt;
  dynamic newSocialUser;
  dynamic customerId;
  dynamic defaultCard;
  dynamic userWallet;
  dynamic isMobileVerified;
  dynamic otpVerified;
  dynamic isApproved;
  dynamic vendorWallet;
  dynamic profileImage;
  dynamic bannerProfile;
  dynamic categoryImage;
  dynamic address;
  dynamic countryId;
  dynamic stateId;
  dynamic city;
  dynamic streetName;
  dynamic block;
  dynamic stripeId;
  dynamic currency;
  dynamic storeOn;
  dynamic readyForOrder;
  dynamic isVendor;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  List<VenderCategory>? venderCategory = [];

  VendorUser(
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
      this.venderCategory});

  VendorUser.fromJson(Map<String, dynamic> json) {
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
    if (json['vender_category'] != null) {
      venderCategory = <VenderCategory>[];
      json['vender_category'].forEach((v) {
        venderCategory!.add(VenderCategory.fromJson(v));
      });
    } else {
      venderCategory = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['store_name'] = storeName;
    data['store_business_id'] = storeBusinessId;
    data['store_about_us'] = storeAboutUs;
    data['store_about_me'] = storeAboutMe;
    data['store_address'] = storeAddress;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_phone'] = storePhone;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['bio'] = bio;
    data['social_id'] = socialId;
    data['api_token'] = apiToken;
    data['device_id'] = deviceId;
    data['device_token'] = deviceToken;
    data['email_verified_at'] = emailVerifiedAt;
    data['new_social_user'] = newSocialUser;
    data['customer_id'] = customerId;
    data['default_card'] = defaultCard;
    data['user_wallet'] = userWallet;
    data['is_mobile_verified'] = isMobileVerified;
    data['otp_verified'] = otpVerified;
    data['is_approved'] = isApproved;
    data['vendor_wallet'] = vendorWallet;
    data['profile_image'] = profileImage;
    data['banner_profile'] = bannerProfile;
    data['category_image'] = categoryImage;
    data['address'] = address;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city'] = city;
    data['street_name'] = streetName;
    data['block'] = block;
    data['stripe_id'] = stripeId;
    data['currency'] = currency;
    data['store_on'] = storeOn;
    data['ready_for_order'] = readyForOrder;
    data['is_vendor'] = isVendor;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (venderCategory != null) {
      data['vender_category'] = venderCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VenderCategory {
  dynamic id;
  dynamic name;
  dynamic status;
  dynamic description;
  dynamic profileImage;
  dynamic bannerProfile;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  VenderCategory(
      {this.id,
      this.name,
      this.status,
      this.description,
      this.profileImage,
      this.bannerProfile,
      this.createdAt,
      this.updatedAt,
      this.pivot});

  VenderCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    profileImage = json['profile_image'];
    bannerProfile = json['banner_profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
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
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  dynamic userId;
  dynamic userVendorCategoryId;

  Pivot({this.userId, this.userVendorCategoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userVendorCategoryId = json['user_vendor_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_vendor_category_id'] = userVendorCategoryId;
    return data;
  }
}
