/// status : true
/// errNum : 0
/// message : "success"
/// home : {"pationts_count":924,"sessions_count":1,"success_story_count":0,"top_advicors":[{"id":18,"pationt_count":342,"advicor":{"id":18,"name":"أ.رحاب سكيك","email":"rehab.sakek@gmail.com","phone_number":"123456","rule":0,"email_verified_at":"2024-07-19T09:46:51.000000Z","created_at":"2024-07-10T17:28:31.000000Z","updated_at":"2024-07-10T17:28:31.000000Z"}},{"id":16,"pationt_count":295,"advicor":{"id":16,"name":"أ.ايه حجازي","email":"aya.hegazy@gmail.com","phone_number":"012345678","rule":0,"email_verified_at":"2024-07-10T13:27:14.000000Z","created_at":"2024-07-10T17:27:14.000000Z","updated_at":"2024-07-10T17:27:14.000000Z"}},{"id":11,"pationt_count":113,"advicor":{"id":11,"name":"د.السيد حراز","email":"sayed.haraz@gmail.com","phone_number":"0123","rule":0,"email_verified_at":"2024-07-10T13:19:59.000000Z","created_at":"2024-07-10T17:19:59.000000Z","updated_at":"2024-07-10T17:19:59.000000Z"}},{"id":12,"pationt_count":65,"advicor":{"id":12,"name":"د .نجوى محجوب","email":"nagwa.mahgob@gmail.com","phone_number":"01234","rule":0,"email_verified_at":"2024-07-19T07:39:13.000000Z","created_at":"2024-07-10T17:23:18.000000Z","updated_at":"2024-07-10T17:23:18.000000Z"}},{"id":17,"pationt_count":61,"advicor":{"id":17,"name":"أ.سهى تقي الدين","email":"Soha.takyeldeen@gmail.com","phone_number":"0123456789","rule":0,"email_verified_at":"2024-07-10T13:27:49.000000Z","created_at":"2024-07-10T17:27:49.000000Z","updated_at":"2024-07-10T17:27:49.000000Z"}},{"id":13,"pationt_count":47,"advicor":{"id":13,"name":"د.خليل مصلح","email":"khalil.mosleh@gmail.com","phone_number":"012345","rule":0,"email_verified_at":"2024-07-10T13:25:36.000000Z","created_at":"2024-07-10T17:25:36.000000Z","updated_at":"2024-07-10T17:25:36.000000Z"}},{"id":15,"pationt_count":1,"advicor":{"id":15,"name":"أ.مصطفى جمعه","email":"mostafa.goma@gmail.com","phone_number":"01234567","rule":0,"email_verified_at":"2024-07-10T13:26:31.000000Z","created_at":"2024-07-10T17:26:31.000000Z","updated_at":"2024-07-10T17:26:31.000000Z"}},{"id":19,"pationt_count":0,"advicor":{"id":19,"name":"advicor","email":"advicor@gmail.com","phone_number":"01018698824","rule":0,"email_verified_at":"2024-07-31T18:11:05.000000Z","created_at":"2024-07-31T22:11:05.000000Z","updated_at":"2024-07-31T22:11:05.000000Z"}},{"id":14,"pationt_count":0,"advicor":{"id":14,"name":"أ.هاني","email":"hany@gmail.com","phone_number":"0123456","rule":0,"email_verified_at":"2024-07-10T13:26:03.000000Z","created_at":"2024-07-10T17:26:03.000000Z","updated_at":"2024-07-10T17:26:03.000000Z"}}],"need_other_session":444,"no_need_other_session":444}

class HomeAdminModel {
  HomeAdminModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.home,});

  HomeAdminModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    home = json['home'] != null ? HomeAdmin.fromJson(json['home']) : null;
  }
  bool? status;
  int? errNum;
  String? message;
  HomeAdmin? home;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (home != null) {
      map['home'] = home?.toJson();
    }
    return map;
  }

}

/// pationts_count : 924
/// sessions_count : 1
/// success_story_count : 0
/// top_advicors : [{"id":18,"pationt_count":342,"advicor":{"id":18,"name":"أ.رحاب سكيك","email":"rehab.sakek@gmail.com","phone_number":"123456","rule":0,"email_verified_at":"2024-07-19T09:46:51.000000Z","created_at":"2024-07-10T17:28:31.000000Z","updated_at":"2024-07-10T17:28:31.000000Z"}},{"id":16,"pationt_count":295,"advicor":{"id":16,"name":"أ.ايه حجازي","email":"aya.hegazy@gmail.com","phone_number":"012345678","rule":0,"email_verified_at":"2024-07-10T13:27:14.000000Z","created_at":"2024-07-10T17:27:14.000000Z","updated_at":"2024-07-10T17:27:14.000000Z"}},{"id":11,"pationt_count":113,"advicor":{"id":11,"name":"د.السيد حراز","email":"sayed.haraz@gmail.com","phone_number":"0123","rule":0,"email_verified_at":"2024-07-10T13:19:59.000000Z","created_at":"2024-07-10T17:19:59.000000Z","updated_at":"2024-07-10T17:19:59.000000Z"}},{"id":12,"pationt_count":65,"advicor":{"id":12,"name":"د .نجوى محجوب","email":"nagwa.mahgob@gmail.com","phone_number":"01234","rule":0,"email_verified_at":"2024-07-19T07:39:13.000000Z","created_at":"2024-07-10T17:23:18.000000Z","updated_at":"2024-07-10T17:23:18.000000Z"}},{"id":17,"pationt_count":61,"advicor":{"id":17,"name":"أ.سهى تقي الدين","email":"Soha.takyeldeen@gmail.com","phone_number":"0123456789","rule":0,"email_verified_at":"2024-07-10T13:27:49.000000Z","created_at":"2024-07-10T17:27:49.000000Z","updated_at":"2024-07-10T17:27:49.000000Z"}},{"id":13,"pationt_count":47,"advicor":{"id":13,"name":"د.خليل مصلح","email":"khalil.mosleh@gmail.com","phone_number":"012345","rule":0,"email_verified_at":"2024-07-10T13:25:36.000000Z","created_at":"2024-07-10T17:25:36.000000Z","updated_at":"2024-07-10T17:25:36.000000Z"}},{"id":15,"pationt_count":1,"advicor":{"id":15,"name":"أ.مصطفى جمعه","email":"mostafa.goma@gmail.com","phone_number":"01234567","rule":0,"email_verified_at":"2024-07-10T13:26:31.000000Z","created_at":"2024-07-10T17:26:31.000000Z","updated_at":"2024-07-10T17:26:31.000000Z"}},{"id":19,"pationt_count":0,"advicor":{"id":19,"name":"advicor","email":"advicor@gmail.com","phone_number":"01018698824","rule":0,"email_verified_at":"2024-07-31T18:11:05.000000Z","created_at":"2024-07-31T22:11:05.000000Z","updated_at":"2024-07-31T22:11:05.000000Z"}},{"id":14,"pationt_count":0,"advicor":{"id":14,"name":"أ.هاني","email":"hany@gmail.com","phone_number":"0123456","rule":0,"email_verified_at":"2024-07-10T13:26:03.000000Z","created_at":"2024-07-10T17:26:03.000000Z","updated_at":"2024-07-10T17:26:03.000000Z"}}]
/// need_other_session : 444
/// no_need_other_session : 444

class HomeAdmin {
  HomeAdmin({
      this.pationtsCount, 
      this.sessionsCount, 
      this.successStoryCount, 
      this.topAdvicors, 
      this.needOtherSession, 
      this.noNeedOtherSession,});

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
    needOtherSession = json['need_other_session'];
    noNeedOtherSession = json['no_need_other_session'];
  }
  int? pationtsCount;
  int? sessionsCount;
  int? successStoryCount;
  List<TopAdvicors>? topAdvicors;
  int? needOtherSession;
  int? noNeedOtherSession;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pationts_count'] = pationtsCount;
    map['sessions_count'] = sessionsCount;
    map['success_story_count'] = successStoryCount;
    if (topAdvicors != null) {
      map['top_advicors'] = topAdvicors?.map((v) => v.toJson()).toList();
    }
    map['need_other_session'] = needOtherSession;
    map['no_need_other_session'] = noNeedOtherSession;
    return map;
  }

}

/// id : 18
/// pationt_count : 342
/// advicor : {"id":18,"name":"أ.رحاب سكيك","email":"rehab.sakek@gmail.com","phone_number":"123456","rule":0,"email_verified_at":"2024-07-19T09:46:51.000000Z","created_at":"2024-07-10T17:28:31.000000Z","updated_at":"2024-07-10T17:28:31.000000Z"}

class TopAdvicors {
  TopAdvicors({
      this.id, 
      this.pationtCount, 
      this.advicor,});

  TopAdvicors.fromJson(dynamic json) {
    id = json['id'];
    pationtCount = json['pationt_count'];
    advicor = json['advicor'] != null ? Advicor.fromJson(json['advicor']) : null;
  }
  int? id;
  int? pationtCount;
  Advicor? advicor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pationt_count'] = pationtCount;
    if (advicor != null) {
      map['advicor'] = advicor?.toJson();
    }
    return map;
  }

}

/// id : 18
/// name : "أ.رحاب سكيك"
/// email : "rehab.sakek@gmail.com"
/// phone_number : "123456"
/// rule : 0
/// email_verified_at : "2024-07-19T09:46:51.000000Z"
/// created_at : "2024-07-10T17:28:31.000000Z"
/// updated_at : "2024-07-10T17:28:31.000000Z"

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