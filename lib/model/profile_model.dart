class ProfileModel {
  bool? status;
  String? message;
  User? user;

  ProfileModel({this.status, this.message, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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

class User {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic dob;
  dynamic countryCode;
  dynamic phone;
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
  dynamic   block;
  dynamic stripeId;
  dynamic currency;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic  deletedAt;

  User(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.dob,
        this.countryCode,
        this.phone,
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
        this.block,
        this.stripeId,
        this.currency,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    email = json['email'] ?? "";
    dob = json['dob'] ?? "";
    countryCode = json['country_code'] ?? "";
    phone = json['phone'] ?? "";
    description = json['description'] ?? "";
    categoryId = json['category_id'] ?? "";
    bio = json['bio'] ?? "";
    socialId = json['social_id'] ?? "";
    apiToken = json['api_token'] ?? "";
    deviceId = json['device_id'] ?? "";
    deviceToken = json['device_token'] ?? "";
    emailVerifiedAt = json['email_verified_at'] ?? "";
    newSocialUser = json['new_social_user'] ?? "";
    customerId = json['customer_id'] ?? "";
    defaultCard = json['default_card'] ?? "";
    userWallet = json['user_wallet'] ?? "";
    isMobileVerified = json['is_mobile_verified'] ?? "";
    otpVerified = json['otp_verified'] ?? "";
    isApproved = json['is_approved'] ?? "";
    vendorWallet = json['vendor_wallet'] ?? "";
    profileImage = json['profile_image'] ?? "";
    bannerProfile = json['banner_profile'] ?? "";
    categoryImage = json['category_image'] ?? "";
    address = json['address'] ?? "";
    block = json['block'] ?? "";
    stripeId = json['stripe_id'] ?? "";
    currency = json['currency'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    deletedAt = json['deleted_at'] ?? "";
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
    data['block'] = block;
    data['stripe_id'] = stripeId;
    data['currency'] = currency;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}