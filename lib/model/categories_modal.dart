class CategoriesModal {
  bool? status;
  String? message;
  List<Data>? data;

  CategoriesModal({this.status, this.message, this.data});

  CategoriesModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? slug;
  String? categoryImage;
  String? categoryImageBanner;
  int? parentId;
  String? arabDescription;
  String? arabTitle;
  int? count;
  List<ChildCategory>? childCategory;

  Data(
      {this.id,
      this.title,
      this.slug,
      this.categoryImage,
      this.categoryImageBanner,
      this.parentId,
      this.arabDescription,
      this.arabTitle,
      this.count,
      this.childCategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
    parentId = json['parent_id'];
    arabDescription = json['arab_description'];
    arabTitle = json['arab_title'];
    count = json['count'];
    if (json['child_category'] != null) {
      childCategory = <ChildCategory>[];
      json['child_category'].forEach((v) {
        childCategory!.add(new ChildCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['category_image'] = this.categoryImage;
    data['category_image_banner'] = this.categoryImageBanner;
    data['parent_id'] = this.parentId;
    data['arab_description'] = this.arabDescription;
    data['arab_title'] = this.arabTitle;
    data['count'] = this.count;
    if (this.childCategory != null) {
      data['child_category'] = this.childCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildCategory {
  int? id;
  String? title;
  String? slug;
  String? categoryImage;
  int? parentId;
  String? arabDescription;
  String? arabTitle;
  List<Null>? subChildCategory;

  ChildCategory(
      {this.id,
      this.title,
      this.slug,
      this.categoryImage,
      this.parentId,
      this.arabDescription,
      this.arabTitle,
      this.subChildCategory});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    parentId = json['parent_id'];
    arabDescription = json['arab_description'];
    arabTitle = json['arab_title'];
    /*if (json['sub_child_category'] != null) {
      subChildCategory = <Null>[];
      json['sub_child_category'].forEach((v) {
        subChildCategory!.add(new Null.fromJson(v));
      });
    }*/
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['category_image'] = this.categoryImage;
    data['parent_id'] = this.parentId;
    data['arab_description'] = this.arabDescription;
    data['arab_title'] = this.arabTitle;
    /* if (this.subChildCategory != null) {
      data['sub_child_category'] =
          this.subChildCategory!.map((v) => v!.toJson()).toList();
    }*/
    return data;
  }
}
