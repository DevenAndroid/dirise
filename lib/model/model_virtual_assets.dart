class ModelVirtualAssets {
  bool? status;
  dynamic message;
  List<VirtualProductData>? product;

  ModelVirtualAssets({this.status, this.message, this.product});

  ModelVirtualAssets.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Product'] != null) {
      product = <VirtualProductData>[];
      json['Product'].forEach((v) {
        product!.add(VirtualProductData.fromJson(v));
      });
    } else {
      product = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['Product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VirtualProductData {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic brandSlug;
  dynamic slug;
  dynamic pname;
  dynamic image;
  dynamic productType;
  dynamic virtualProductType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic bestSaller;
  dynamic featured;
  dynamic taxApply;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic virtualProductFile;
  dynamic virtualProductFileType;
  dynamic inStock;
  dynamic stockAlert;
  dynamic avgRating;
  dynamic parentId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic topHunderd;
  dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;

  VirtualProductData(
      {this.id,
        this.vendorId,
        this.catId,
        this.brandSlug,
        this.slug,
        this.pname,
        this.image,
        this.productType,
        this.virtualProductType,
        this.skuId,
        this.pPrice,
        this.sPrice,
        this.commission,
        this.bestSaller,
        this.featured,
        this.taxApply,
        this.shortDescription,
        this.longDescription,
        this.featuredImage,
        this.galleryImage,
        this.virtualProductFile,
        this.virtualProductFileType,
        this.inStock,
        this.stockAlert,
        this.avgRating,
        this.parentId,
        this.createdAt,
        this.updatedAt,
        this.topHunderd,
        this.returnDays,
        this.isPublish,
        this.inOffer,
        this.forAuction,
      });

  VirtualProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    image = json['image'];
    productType = json['product_type'];
    virtualProductType = json['virtual_product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    commission = json['commission'];
    bestSaller = json['best_saller'];
    featured = json['featured'];
    taxApply = json['tax_apply'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'].cast<String>();
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    inStock = json['in_stock'];
    stockAlert = json['stock_alert'];
    avgRating = json['avg_rating'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topHunderd = json['top_hunderd'];
    returnDays = json['return_days'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['brand_slug'] = brandSlug;
    data['slug'] = slug;
    data['pname'] = pname;
    data['image'] = image;
    data['product_type'] = productType;
    data['virtual_product_type'] = virtualProductType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['commission'] = commission;
    data['best_saller'] = bestSaller;
    data['featured'] = featured;
    data['tax_apply'] = taxApply;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['in_stock'] = inStock;
    data['stock_alert'] = stockAlert;
    data['avg_rating'] = avgRating;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_hunderd'] = topHunderd;
    data['return_days'] = returnDays;
    data['is_publish'] = isPublish;
    data['in_offer'] = inOffer;
    data['for_auction'] = forAuction;
    return data;
  }
}
