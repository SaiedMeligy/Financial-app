/// status : true
/// errNum : 0
/// message : "success"
/// pationts : [{"id":5,"name":"زياد احمد","email":"zeiad@eg.et","phone_number":"0123456789","national_id":"0123456789","created_at":"2024-05-29T01:59:46.000000Z","updated_at":"2024-05-29T01:59:46.000000Z"},{"id":6,"name":"سعيد مليجي","email":"sa@eg.et","phone_number":"01234567890","national_id":"01234567890","created_at":"2024-05-29T02:56:40.000000Z","updated_at":"2024-05-29T02:56:40.000000Z"},{"id":7,"name":"سامح وليج","email":"sameh@eg.et","phone_number":"012345678900","national_id":"012345678900","created_at":"2024-05-29T03:16:00.000000Z","updated_at":"2024-05-29T03:16:00.000000Z"}]

class AllPatientModel {
  AllPatientModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.pationts,});

  AllPatientModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['pationts'] != null) {
      pationts = [];
      json['pationts'].forEach((v) {
        pationts?.add(Pationts.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Pationts>? pationts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (pationts != null) {
      map['pationts'] = pationts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 5
/// name : "زياد احمد"
/// email : "zeiad@eg.et"
/// phone_number : "0123456789"
/// national_id : "0123456789"
/// created_at : "2024-05-29T01:59:46.000000Z"
/// updated_at : "2024-05-29T01:59:46.000000Z"

class Pationts {
  Pationts({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNumber, 
      this.nationalId, 
      this.createdAt, 
      this.updatedAt,});

  Pationts.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nationalId = json['national_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? nationalId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['national_id'] = nationalId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}