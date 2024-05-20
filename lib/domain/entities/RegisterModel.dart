// /// status : true
// /// errNum : 0
// /// message : "success register"
// /// user : {"name":"saied","rule":"1","email":"saied@gmail.com","phone_number":"01156366044","updated_at":"2024-05-20T14:52:44.000000Z","created_at":"2024-05-20T14:52:44.000000Z","id":6}
//
// class RegisterModel {
//   RegisterModel({
//       this.status,
//       this.errNum,
//       this.message,
//       this.user,});
//
//   RegisterModel.fromJson(dynamic json) {
//     status = json['status'];
//     errNum = json['errNum'];
//     message = json['message'];
//     user = json['user'] != null ? RegisterDataRequest.fromJson(json['user']) : null;
//   }
//   bool? status;
//   int? errNum;
//   String? message;
//   RegisterDataRequest? user;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['errNum'] = errNum;
//     map['message'] = message;
//     if (user != null) {
//       map['user'] = user?.toJson();
//     }
//     return map;
//   }
//
// }
//
// /// name : "saied"
// /// rule : "1"
// /// email : "saied@gmail.com"
// /// phone_number : "01156366044"
// /// updated_at : "2024-05-20T14:52:44.000000Z"
// /// created_at : "2024-05-20T14:52:44.000000Z"
// /// id : 6
//
// class RegisterDataRequest {
//   String? name;
//   String? rule;
//   String? email;
//   String? password;
//   String? phoneNumber;
//   String? updatedAt;
//   String? createdAt;
//   int? id;
//   RegisterDataRequest({
//       this.name,
//       this.rule,
//       this.email,
//     this.password,
//       this.phoneNumber,
//       this.updatedAt,
//       this.createdAt,
//       this.id,});
//
//   RegisterDataRequest.fromJson(dynamic json) {
//     name = json['name'];
//     rule = json['rule'];
//     email = json['email'];
//     password = json['password'];
//     phoneNumber = json['phone_number'];
//     updatedAt = json['updated_at'];
//     createdAt = json['created_at'];
//     id = json['id'];
//   }
//
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = name;
//     map['rule'] = rule;
//     map['email'] = email;
//     map['password'] = password;
//     map['phone_number'] = phoneNumber;
//     map['updated_at'] = updatedAt;
//     map['created_at'] = createdAt;
//     map['id'] = id;
//     return map;
//   }
//
// }
class RegisterDataRequest {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String rule;

  RegisterDataRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.rule,
  });
}
