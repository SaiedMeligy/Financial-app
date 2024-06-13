/// status : true
/// errNum : 0
/// message : "success"
/// advisors : [{"id":1,"name":"ahmed saied","email":"ahmed@gmail.com","phone_number":"01090917016","rule":0,"email_verified_at":"2024-05-15T02:59:22.000000Z","created_at":"2024-05-14T23:59:22.000000Z","updated_at":"2024-05-14T23:59:22.000000Z"},{"id":4,"name":"زياد","email":"zeiad@eg.et","phone_number":"01234567890","rule":0,"email_verified_at":"2024-05-21T02:45:44.000000Z","created_at":"2024-05-20T23:45:44.000000Z","updated_at":"2024-05-20T23:45:44.000000Z"},{"id":5,"name":"ahmed","email":"ahmed@eg.et","phone_number":"1234567","rule":0,"email_verified_at":"2024-05-21T02:56:56.000000Z","created_at":"2024-05-20T23:56:56.000000Z","updated_at":"2024-05-20T23:56:56.000000Z"},{"id":6,"name":"سامح وليد","email":"sameh@gmail.com","phone_number":"012345678900","rule":0,"email_verified_at":"2024-05-24T01:07:20.000000Z","created_at":"2024-05-23T22:07:20.000000Z","updated_at":"2024-05-23T22:07:20.000000Z"},{"id":7,"name":"zeiad","email":"zeiad@gmail.com","phone_number":"1234567890","rule":0,"email_verified_at":"2024-05-24T01:12:21.000000Z","created_at":"2024-05-23T22:12:21.000000Z","updated_at":"2024-05-23T22:12:21.000000Z"},{"id":8,"name":"advicor","email":"advicor@gmail.com","phone_number":"01018698824","rule":0,"email_verified_at":"2024-05-24T03:59:16.000000Z","created_at":"2024-05-24T00:59:16.000000Z","updated_at":"2024-05-24T00:59:16.000000Z"},{"id":9,"name":"زياد احمد","email":"zeiadahmed@eg.et","phone_number":"0123456789","rule":0,"email_verified_at":"2024-05-29T04:58:27.000000Z","created_at":"2024-05-29T01:58:27.000000Z","updated_at":"2024-05-29T01:58:27.000000Z"}]

class AllAdvisorsModel {
  AllAdvisorsModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.advisors,});

  AllAdvisorsModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['advisors'] != null) {
      advisors = [];
      json['advisors'].forEach((v) {
        advisors?.add(Advisors.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Advisors>? advisors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (advisors != null) {
      map['advisors'] = advisors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "ahmed saied"
/// email : "ahmed@gmail.com"
/// phone_number : "01090917016"
/// rule : 0
/// email_verified_at : "2024-05-15T02:59:22.000000Z"
/// created_at : "2024-05-14T23:59:22.000000Z"
/// updated_at : "2024-05-14T23:59:22.000000Z"

class Advisors {
  Advisors({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNumber, 
      this.rule, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt,});

  Advisors.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    rule = json['rule'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  int? rule;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['rule'] = rule;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}