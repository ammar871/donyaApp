class CategoryProfession {
  int? id;
  int? status;
  String? nameArbice;
  String? nameEnglish;
  String? nameFrance;
  String? image;

  CategoryProfession(
      {this.id,
        this.status,
        this.nameArbice,
        this.nameEnglish,
        this.nameFrance,
        this.image});

  CategoryProfession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    nameArbice = json['nameArbice'];
    nameEnglish = json['nameEnglish'];
    nameFrance = json['nameFrance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['nameArbice'] = this.nameArbice;
    data['nameEnglish'] = this.nameEnglish;
    data['nameFrance'] = this.nameFrance;
    data['image'] = this.image;
    return data;
  }
}
