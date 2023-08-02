class ModelVendorProductDetails {
  bool? status;
  String? message;
  ModelVendorProductDetailsData? product;

  ModelVendorProductDetails({this.status, this.message, this.product});

  ModelVendorProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
    json['product'] != null ? ModelVendorProductDetailsData.fromJson(json['product']) : null;
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
  dynamic prodectSku;
  dynamic bookingProductType;
  int? regularPrice;
  int? sPrice;
  String? productType;
  String? shortDescription;
  String? longDescription;
  String? featuredImage;
  List<String>? galleryImage;
  String? virtualProductFile;
  dynamic virtualProductFileType;
  String? inStock;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;
  String? returnDays;

  ModelVendorProductDetailsData(
      {this.catId,
        this.brandSlug,
        this.slug,
        this.pname,
        this.prodectSku,
        this.bookingProductType,
        this.regularPrice,
        this.sPrice,
        this.productType,
        this.shortDescription,
        this.longDescription,
        this.featuredImage,
        this.galleryImage,
        this.virtualProductFile,
        this.virtualProductFileType,
        this.inStock,
        this.serviceTimeSloat,
        this.productAvailability,
        this.returnDays});

  ModelVendorProductDetailsData.fromJson(Map<String, dynamic> json) {
    catId = json['cat_id'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    prodectSku = json['prodect_sku'];
    bookingProductType = json['booking_product_type'];
    regularPrice = json['regular_price'];
    sPrice = json['s_price'];
    productType = json['product_type'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'].cast<String>();
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cat_id'] = catId;
    data['brand_slug'] = brandSlug;
    data['slug'] = slug;
    data['pname'] = pname;
    data['prodect_sku'] = prodectSku;
    data['booking_product_type'] = bookingProductType;
    data['regular_price'] = regularPrice;
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
      data['serviceTimeSloat'] =
          serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    if (productAvailability != null) {
      data['productAvailability'] = productAvailability!.toJson();
    }
    data['return_days'] = returnDays;
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
