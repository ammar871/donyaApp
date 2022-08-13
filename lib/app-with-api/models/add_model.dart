class AddModel {
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
  String? lat;
  String? lang;
  String? images;
  String? date;
  String? homeCategory;
  String? subCategory;
  String? token;
  AddModel(
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
        this.lat,
        this.lang,
        this.images,
        this.subCategory,
        this.homeCategory,
        this.token,
        this.date});

  AddModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    title = json['title'];
    address = json['address'];
    homeCategory = json['homeCategory'];
    subCategory = json['subCategory'];
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
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['images'] = this.images;
    data['date'] = this.date;
    data['token'] = this.token;
    data['homeCategory'] = this.homeCategory;
    data['subCategory'] = this.subCategory;
    return data;
  }
}
class ResponseAdd {
  List<AddModel>? currentAdds;
  List<AddModel>? unacceptableAdds;
  List<AddModel>? spoonAdds;

  ResponseAdd({this.currentAdds, this.unacceptableAdds, this.spoonAdds});

  ResponseAdd.fromJson(Map<String, dynamic> json) {
    if (json['currentAdds'] != null) {
      currentAdds = <AddModel>[];
      json['currentAdds'].forEach((v) {
        currentAdds!.add(new AddModel.fromJson(v));
      });
    }
    if (json['unacceptableAdds'] != null) {
      unacceptableAdds = <AddModel>[];
      json['unacceptableAdds'].forEach((v) {
        unacceptableAdds!.add(new AddModel.fromJson(v));
      });
    }
    if (json['spoonAdds'] != null) {
      spoonAdds = <AddModel>[];
      json['spoonAdds'].forEach((v) {
        spoonAdds!.add(new AddModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currentAdds != null) {
      data['currentAdds'] = this.currentAdds!.map((v) => v.toJson()).toList();
    }
    if (this.unacceptableAdds != null) {
      data['unacceptableAdds'] =
          this.unacceptableAdds!.map((v) => v.toJson()).toList();
    }
    if (this.spoonAdds != null) {
      data['spoonAdds'] = this.spoonAdds!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class AddPagination {
  List<AddModel>? items;
  int? currentPage;
  int? totalPage;

  AddPagination({this.items, this.currentPage, this.totalPage});

  AddPagination.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new AddModel.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

