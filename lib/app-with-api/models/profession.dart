class Profession {
  int? id;
  int? categoryId;
  String? title;
  String? address;
  String? desc;
  String? advertiserName;
  String? phone;
  String? phoneWhats;
  bool? isImage;
  int? status;
  String? userId;
  String? country;
  String? token;
  String? lat;
  String? lang;
  String? images;
  String? date;

  Profession(
      {this.id,
        this.categoryId,
        this.title,
        this.address,
        this.desc,
        this.advertiserName,
        this.phone,
        this.phoneWhats,
        this.isImage,
        this.status,
        this.userId,
        this.country,
        this.token,
        this.lat,
        this.lang,
        this.images,
        this.date});

  Profession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    title = json['title'];
    address = json['address'];
    desc = json['desc'];
    advertiserName = json['advertiserName'];
    phone = json['phone'];
    phoneWhats = json['phoneWhats'];
    isImage = json['isImage'];
    status = json['status'];
    userId = json['userId'];
    country = json['country'];
    token = json['token'];
    lat = json['lat'];
    lang = json['lang'];
    images = json['images'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['title'] = this.title;
    data['address'] = this.address;
    data['desc'] = this.desc;
    data['advertiserName'] = this.advertiserName;
    data['phone'] = this.phone;
    data['phoneWhats'] = this.phoneWhats;
    data['isImage'] = this.isImage;
    data['status'] = this.status;
    data['userId'] = this.userId;
    data['country'] = this.country;
    data['token'] = this.token;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['images'] = this.images;
    data['date'] = this.date;
    return data;
  }
}
