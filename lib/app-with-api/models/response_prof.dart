class ResponseProfessional {
  var id;
  String? email;
  String? city;
  String? password;
  String? phone;
  var professionId;
  String? fullName;
  String? details;
  String? userId;
  int? status;
  String? createdAt;

  ResponseProfessional(
      {this.id,
        this.email,
        this.city,
        this.password,
        this.phone,
        this.professionId,
        this.fullName,
        this.details,
        this.userId,
        this.status,
        this.createdAt});

  ResponseProfessional.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    city = json['city'];
    password = json['password'];
    phone = json['phone'];
    professionId = json['professionId'];
    fullName = json['fullName'];
    details = json['details'];
    userId = json['userId'];
    status = json['status'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['city'] = this.city;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['professionId'] = this.professionId;
    data['fullName'] = this.fullName;
    data['details'] = this.details;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
