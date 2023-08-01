class ModelProductsList {
  bool? status;
  dynamic message;
  List<ProductListData>? data = [];

  ModelProductsList({this.status, this.message, this.data});

  ModelProductsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductListData>[];
      json['data'].forEach((v) {
        data!.add(ProductListData.fromJson(v));
      });
    } else {
      data = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductListData {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic slug;
  dynamic brandSlug;
  dynamic pname;
  dynamic productType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic taxApply;
  dynamic taxType;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic featuredImage;
  dynamic galleryImage;
  dynamic inStock;
  dynamic featured;
  dynamic bestSaller;
  dynamic parentId;
  dynamic commission;
  dynamic topHunderd;
  dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic stockAlert;
  dynamic virtualProductFile;

  ProductListData(
      {this.id,
        this.vendorId,
        this.catId,
        this.slug,
        this.brandSlug,
        this.pname,
        this.productType,
        this.skuId,
        this.pPrice,
        this.sPrice,
        this.taxApply,
        this.taxType,
        this.shortDescription,
        this.longDescription,
        this.featuredImage,
        this.galleryImage,
        this.inStock,
        this.featured,
        this.bestSaller,
        this.parentId,
        this.commission,
        this.topHunderd,
        this.returnDays,
        this.isPublish,
        this.inOffer,
        this.forAuction,
        this.stockAlert,
        this.virtualProductFile});

  ProductListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    catId = json['cat_id'];
    slug = json['slug'];
    brandSlug = json['brand_slug'];
    pname = json['pname'];
    productType = json['product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    taxApply = json['tax_apply'];
    taxType = json['tax_type'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'];
    inStock = json['in_stock'];
    featured = json['featured'];
    bestSaller = json['best_saller'];
    parentId = json['parent_id'];
    commission = json['commission'];
    topHunderd = json['top_hunderd'];
    returnDays = json['return_days'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];
    stockAlert = json['stock_alert'];
    virtualProductFile = json['virtual_product_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['cat_id'] = catId;
    data['slug'] = slug;
    data['brand_slug'] = brandSlug;
    data['pname'] = pname;
    data['product_type'] = productType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['tax_apply'] = taxApply;
    data['tax_type'] = taxType;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['in_stock'] = inStock;
    data['featured'] = featured;
    data['best_saller'] = bestSaller;
    data['parent_id'] = parentId;
    data['commission'] = commission;
    data['top_hunderd'] = topHunderd;
    data['return_days'] = returnDays;
    data['is_publish'] = isPublish;
    data['in_offer'] = inOffer;
    data['for_auction'] = forAuction;
    data['stock_alert'] = stockAlert;
    data['virtual_product_file'] = virtualProductFile;
    return data;
  }
}
