class AdvisorModel {
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  int? rule;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  String? password;

  AdvisorModel(
      {this.id,
        this.name,
        this.email,
        this.phoneNumber,
        this.rule,
        this.emailVerifiedAt,
        this.password,
        this.createdAt,
        this.updatedAt});

  AdvisorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    rule = json['rule'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone_number'] = this.phoneNumber;
    data['rule'] = this.rule;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}