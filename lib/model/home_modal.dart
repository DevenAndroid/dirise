class HomeModal {
  bool? status;
  String? message;
  Home? home;

  HomeModal({this.status, this.message, this.home});

  HomeModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    home = json['home'] != null ? new Home.fromJson(json['home']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.home != null) {
      data['home'] = this.home!.toJson();
    }
    return data;
  }
}

class Home {
  String? content;
  List<Slider>? slider;
  String? bannerImg;
  String? saleBannerAltTag;
  String? saleBannerUrl;

  Home({this.content, this.slider, this.bannerImg, this.saleBannerAltTag, this.saleBannerUrl});

  Home.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    if (json['slider'] != null) {
      slider = <Slider>[];
      json['slider'].forEach((v) {
        slider!.add(new Slider.fromJson(v));
      });
    }
    bannerImg = json['banner_img'];
    saleBannerAltTag = json['sale_banner_alt_tag'];
    saleBannerUrl = json['sale_banner_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    if (this.slider != null) {
      data['slider'] = this.slider!.map((v) => v.toJson()).toList();
    }
    data['banner_img'] = this.bannerImg;
    data['sale_banner_alt_tag'] = this.saleBannerAltTag;
    data['sale_banner_url'] = this.saleBannerUrl;
    return data;
  }
}

class Slider {
  String? image;
  String? bannerMobile;
  String? url;
  String? sliderAlt;

  Slider({this.image, this.bannerMobile, this.url, this.sliderAlt});

  Slider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    bannerMobile = json['banner_mobile'];
    url = json['url'];
    sliderAlt = json['slider_alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['banner_mobile'] = this.bannerMobile;
    data['url'] = this.url;
    data['slider_alt'] = this.sliderAlt;
    return data;
  }
}
