/// status : true
/// errNum : 0
/// message : "success"
/// home : {"pationts_count":8,"sessions_count":9,"success_story_count":1,"top_advicors":[{"pationt_count":4,"advicor":{"id":9,"name":"زياد احمد","email":"zeiadahmed@eg.et","phone_number":"0123456789","rule":0,"email_verified_at":"2024-05-29T04:58:27.000000Z","created_at":"2024-05-29T01:58:27.000000Z","updated_at":"2024-05-29T01:58:27.000000Z"}},{"pationt_count":1,"advicor":{"id":4,"name":"زياد","email":"zeiad@eg.et","phone_number":"01234567890","rule":0,"email_verified_at":"2024-05-21T02:45:44.000000Z","created_at":"2024-05-20T23:45:44.000000Z","updated_at":"2024-05-20T23:45:44.000000Z"}},{"pationt_count":1,"advicor":{"id":6,"name":"سامح وليد","email":"sameh@gmail.com","phone_number":"012345678900","rule":0,"email_verified_at":"2024-05-24T01:07:20.000000Z","created_at":"2024-05-23T22:07:20.000000Z","updated_at":"2024-05-23T22:07:20.000000Z"}},{"pationt_count":0,"advicor":{"id":1,"name":"ahmed saied","email":"ahmed@gmail.com","phone_number":"01090917016","rule":0,"email_verified_at":"2024-05-15T02:59:22.000000Z","created_at":"2024-05-14T23:59:22.000000Z","updated_at":"2024-05-14T23:59:22.000000Z"}},{"pationt_count":0,"advicor":{"id":5,"name":"ahmed","email":"ahmed@eg.et","phone_number":"1234567","rule":0,"email_verified_at":"2024-05-21T02:56:56.000000Z","created_at":"2024-05-20T23:56:56.000000Z","updated_at":"2024-05-20T23:56:56.000000Z"}},{"pationt_count":0,"advicor":{"id":7,"name":"zeiad","email":"zeiad@gmail.com","phone_number":"1234567890","rule":0,"email_verified_at":"2024-05-24T01:12:21.000000Z","created_at":"2024-05-23T22:12:21.000000Z","updated_at":"2024-05-23T22:12:21.000000Z"}},{"pationt_count":0,"advicor":{"id":8,"name":"advicor","email":"advicor@gmail.com","phone_number":"01018698824","rule":0,"email_verified_at":"2024-05-24T03:59:16.000000Z","created_at":"2024-05-24T00:59:16.000000Z","updated_at":"2024-05-24T00:59:16.000000Z"}}],"senarios_report":[{"id":1,"name":"السيناريو الأول","created_at":"2024-05-20T17:52:17.000000Z","updated_at":"2024-05-20T17:52:17.000000Z","pointers_count":2,"pationts_pointers_count":2},{"id":2,"name":"السناريو الثاني","created_at":"2024-05-20T17:52:17.000000Z","updated_at":"2024-05-20T17:52:17.000000Z","pointers_count":1,"pationts_pointers_count":0},{"id":3,"name":"السناريو الثالث","created_at":"2024-05-20T17:52:17.000000Z","updated_at":"2024-05-20T17:52:17.000000Z","pointers_count":1,"pationts_pointers_count":0}]}

class HomeAdminModel {
  HomeAdminModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.homeAdmin,});

  HomeAdminModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    homeAdmin = json['home'] != null ? HomeAdmin.fromJson(json['home']) : null;
  }
  bool? status;
  int? errNum;
  String? message;
  HomeAdmin? homeAdmin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (homeAdmin != null) {
      map['home'] = homeAdmin?.toJson();
    }
    return map;
  }

}

/// pationts_count : 8
/// sessions_count : 9
/// success_story_count : 1
/// top_advicors : [{"pationt_count":4,"advicor":{"id":9,"name":"زياد احمد","email":"zeiadahmed@eg.et","phone_number":"0123456789","rule":0,"email_verified_at":"2024-05-29T04:58:27.000000Z","created_at":"2024-05-29T01:58:27.000000Z","updated_at":"2024-05-29T01:58:27.000000Z"}},{"pationt_count":1,"advicor":{"id":4,"name":"زياد","email":"zeiad@eg.et","phone_number":"01234567890","rule":0,"email_verified_at":"2024-05-21T02:45:44.000000Z","created_at":"2024-05-20T23:45:44.000000Z","updated_at":"2024-05-20T23:45:44.000000Z"}},{"pationt_count":1,"advicor":{"id":6,"name":"سامح وليد","email":"sameh@gmail.com","phone_number":"012345678900","rule":0,"email_verified_at":"2024-05-24T01:07:20.000000Z","created_at":"2024-05-23T22:07:20.000000Z","updated_at":"2024-05-23T22:07:20.000000Z"}},{"pationt_count":0,"advicor":{"id":1,"name":"ahmed saied","email":"ahmed@gmail.com","phone_number":"01090917016","rule":0,"email_verified_at":"2024-05-15T02:59:22.000000Z","created_at":"2024-05-14T23:59:22.000000Z","updated_at":"2024-05-14T23:59:22.000000Z"}},{"pationt_count":0,"advicor":{"id":5,"name":"ahmed","email":"ahmed@eg.et","phone_number":"1234567","rule":0,"email_verified_at":"2024-05-21T02:56:56.000000Z","created_at":"2024-05-20T23:56:56.000000Z","updated_at":"2024-05-20T23:56:56.000000Z"}},{"pationt_count":0,"advicor":{"id":7,"name":"zeiad","email":"zeiad@gmail.com","phone_number":"1234567890","rule":0,"email_verified_at":"2024-05-24T01:12:21.000000Z","created_at":"2024-05-23T22:12:21.000000Z","updated_at":"2024-05-23T22:12:21.000000Z"}},{"pationt_count":0,"advicor":{"id":8,"name":"advicor","email":"advicor@gmail.com","phone_number":"01018698824","rule":0,"email_verified_at":"2024-05-24T03:59:16.000000Z","created_at":"2024-05-24T00:59:16.000000Z","updated_at":"2024-05-24T00:59:16.000000Z"}}]
/// senarios_report : [{"id":1,"name":"السيناريو الأول","created_at":"2024-05-20T17:52:17.000000Z","updated_at":"2024-05-20T17:52:17.000000Z","pointers_count":2,"pationts_pointers_count":2},{"id":2,"name":"السناريو الثاني","created_at":"2024-05-20T17:52:17.000000Z","updated_at":"2024-05-20T17:52:17.000000Z","pointers_count":1,"pationts_pointers_count":0},{"id":3,"name":"السناريو الثالث","created_at":"2024-05-20T17:52:17.000000Z","updated_at":"2024-05-20T17:52:17.000000Z","pointers_count":1,"pationts_pointers_count":0}]

class HomeAdmin {
  HomeAdmin({
      this.pationtsCount, 
      this.sessionsCount, 
      this.successStoryCount, 
      this.topAdvicors,});

  HomeAdmin.fromJson(dynamic json) {
    pationtsCount = json['pationts_count'];
    sessionsCount = json['sessions_count'];
    successStoryCount = json['success_story_count'];
    if (json['top_advicors'] != null) {
      topAdvicors = [];
      json['top_advicors'].forEach((v) {
        topAdvicors?.add(TopAdvicors.fromJson(v));
      });
    }
    // if (json['senarios_report'] != null) {
    //   senariosReport = [];
    //   json['senarios_report'].forEach((v) {
    //     senariosReport?.add(SenariosReport.fromJson(v));
    //   });
    // }
  }
  int? pationtsCount;
  int? sessionsCount;
  int? successStoryCount;
  List<TopAdvicors>? topAdvicors;
  // List<SenariosReport>? senariosReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pationts_count'] = pationtsCount;
    map['sessions_count'] = sessionsCount;
    map['success_story_count'] = successStoryCount;
    if (topAdvicors != null) {
      map['top_advicors'] = topAdvicors?.map((v) => v.toJson()).toList();
    }
    // if (senariosReport != null) {
    //   map['senarios_report'] = senariosReport?.map((v) => v.toJson()).toList();
    // }
     return map;
  }

}

/// id : 1
/// name : "السيناريو الأول"
/// created_at : "2024-05-20T17:52:17.000000Z"
/// updated_at : "2024-05-20T17:52:17.000000Z"
/// pointers_count : 2
/// pationts_pointers_count : 2

class SenariosReport {
  SenariosReport({
      this.id, 
      this.name, 
      this.createdAt, 
      this.updatedAt, 
      this.pointersCount, 
      this.pationtsPointersCount,});

  SenariosReport.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pointersCount = json['pointers_count'];
    pationtsPointersCount = json['pationts_pointers_count'];
  }
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  int? pointersCount;
  int? pationtsPointersCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['pointers_count'] = pointersCount;
    map['pationts_pointers_count'] = pationtsPointersCount;
    return map;
  }

}

/// pationt_count : 4
/// advicor : {"id":9,"name":"زياد احمد","email":"zeiadahmed@eg.et","phone_number":"0123456789","rule":0,"email_verified_at":"2024-05-29T04:58:27.000000Z","created_at":"2024-05-29T01:58:27.000000Z","updated_at":"2024-05-29T01:58:27.000000Z"}

class TopAdvicors {
  TopAdvicors({
      this.pationtCount, 
      this.advicor,});

  TopAdvicors.fromJson(dynamic json) {
    pationtCount = json['pationt_count'];
    advicor = json['advicor'] != null ? Advicor.fromJson(json['advicor']) : null;
  }
  int? pationtCount;
  Advicor? advicor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pationt_count'] = pationtCount;
    if (advicor != null) {
      map['advicor'] = advicor?.toJson();
    }
    return map;
  }

}

/// id : 9
/// name : "زياد احمد"
/// email : "zeiadahmed@eg.et"
/// phone_number : "0123456789"
/// rule : 0
/// email_verified_at : "2024-05-29T04:58:27.000000Z"
/// created_at : "2024-05-29T01:58:27.000000Z"
/// updated_at : "2024-05-29T01:58:27.000000Z"

class Advicor {
  Advicor({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNumber, 
      this.rule, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt,});

  Advicor.fromJson(dynamic json) {
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