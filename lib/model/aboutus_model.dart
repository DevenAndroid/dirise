class AboutUsmodel {
  bool? status;
  String? message;
  Data? data;

  AboutUsmodel({this.status, this.message, this.data});

  AboutUsmodel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? title;
  Null? arabTitle;
  String? content;
  Null? arabContent;
  String? metatitle;
  String? metaDetails;
  String? metaKeyword;

  Data(
      {this.id,
        this.title,
        this.arabTitle,
        this.content,
        this.arabContent,
        this.metatitle,
        this.metaDetails,
        this.metaKeyword});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    arabTitle = json['arab_title'];
    content = json['content'];
    arabContent = json['arab_content'];
    metatitle = json['metatitle'];
    metaDetails = json['meta_details'];
    metaKeyword = json['meta_keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['arab_title'] = this.arabTitle;
    data['content'] = this.content;
    data['arab_content'] = this.arabContent;
    data['metatitle'] = this.metatitle;
    data['meta_details'] = this.metaDetails;
    data['meta_keyword'] = this.metaKeyword;
    return data;
  }
}
