class ModelVendorProductDetails {
  bool? status;
  String? message;
  ModelVendorProductDetailsData? product;

  ModelVendorProductDetails({this.status, this.message, this.product});

  ModelVendorProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product = json['product'] != null ? ModelVendorProductDetailsData.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class ModelVendorProductDetailsData {
  int? catId;
  String? brandSlug;
  String? slug;
  String? pname;
  dynamic sku_id;
  dynamic bookingProductType;
  int? p_price;
  int? sPrice;
  String? productType;
  String? shortDescription;
  String? longDescription;
  String? featuredImage;
  List<String>? galleryImage = [];
  List<String>? galleryTempData = [];
  String? virtualProductFile;
  dynamic virtualProductFileType;
  dynamic weight;
  dynamic weight_unit;
  String? inStock;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;
  String? returnDays;
  List<VariantData>? variantData;

  ModelVendorProductDetailsData(
      {this.catId,
      this.brandSlug,
      this.slug,
      this.pname,
      this.weight,
      this.sku_id,
      this.weight_unit,
      this.bookingProductType,
      this.variantData,
      this.p_price,
      this.sPrice,
      this.productType,
      this.shortDescription,
      this.longDescription,
      this.featuredImage,
      this.galleryImage,
      this.galleryTempData,
      this.virtualProductFile,
      this.virtualProductFileType,
      this.inStock,
      this.serviceTimeSloat,
      this.productAvailability,
      this.returnDays});

  ModelVendorProductDetailsData.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    weight_unit = json['weight_unit'];
    weight = json['weight'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    sku_id = json['sku_id'];
    bookingProductType = json['booking_product_type'];
    p_price = json['p_price'];
    sPrice = json['s_price'];
    productType = json['product_type'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'] != null ? json['gallery_image'].cast<String>() : [];
    galleryTempData = json['galleryTempData'] != null ? json['galleryTempData'].cast<String>() : [];
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    inStock = json['in_stock'];
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(ServiceTimeSloat.fromJson(v));
      });
    }
    productAvailability = json['productAvailability'] != null && json['productAvailability'].toString().isNotEmpty
        ? ProductAvailability.fromJson(json['productAvailability'])
        : null;
    returnDays = json['return_days'];
    if (json['variant_data'] != null) {
      variantData = <VariantData>[];
      json['variant_data'].forEach((v) {
        variantData!.add(VariantData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['brand_slug'] = brandSlug;
    data['weight'] = weight;
    data['weight_unit'] = weight_unit;
    data['slug'] = slug;
    data['pname'] = pname;
    data['sku_id'] = sku_id;
    data['booking_product_type'] = bookingProductType;
    data['p_price'] = p_price;
    data['s_price'] = sPrice;
    data['product_type'] = productType;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['in_stock'] = inStock;
    if (serviceTimeSloat != null) {
      data['serviceTimeSloat'] = serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    if (productAvailability != null) {
      data['productAvailability'] = productAvailability!.toJson();
    }
    data['return_days'] = returnDays;
    if (variantData != null) {
      data['variant_data'] = variantData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceTimeSloat {
  String? timeSloat;
  String? timeSloatEnd;

  ServiceTimeSloat({this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}

class ProductAvailability {
  int? qty;
  String? type;
  String? fromDate;
  String? toDate;

  ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }
}



class VariantData {
  int? parentId;
  int? pId;
  Map<String, dynamic> variantValue = {};
  String? variantSku;
  String? variantPrice;
  int? variantStock;
  String? variantImages;

  VariantData(
      {this.parentId,
        this.pId,
        required this.variantValue,
        this.variantSku,
        this.variantPrice,
        this.variantStock,
        this.variantImages});

  VariantData.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    pId = json['p_id'];
    variantValue = json['variant_value'] ?? {};
    variantSku = json['variant_sku'];
    variantPrice = json['variant_price'];
    variantStock = json['variant_stock'];
    variantImages = json['variant_images'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = parentId;
    data['p_id'] = pId;
    // if (variantValue != null) {
    //   data['variant_value'] = variantValue!.toJson();
    // }
    data['variant_sku'] = variantSku;
    data['variant_price'] = variantPrice;
    data['variant_stock'] = variantStock;
    data['variant_images'] = variantImages;
    return data;
  }
}
