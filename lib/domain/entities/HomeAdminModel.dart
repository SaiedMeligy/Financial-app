/// status : true
/// errNum : 0
/// message : "success"
/// home : {"pationts_count":924,"sessions_count":1,"success_story_count":0,"top_advicors":[{"id":18,"pationt_count":342,"advicor":{"id":18,"name":"أ.رحاب سكيك","email":"rehab.sakek@gmail.com","phone_number":"123456","rule":0,"email_verified_at":"2024-07-19T09:46:51.000000Z","created_at":"2024-07-10T17:28:31.000000Z","updated_at":"2024-07-10T17:28:31.000000Z"}},{"id":16,"pationt_count":295,"advicor":{"id":16,"name":"أ.ايه حجازي","email":"aya.hegazy@gmail.com","phone_number":"012345678","rule":0,"email_verified_at":"2024-07-10T13:27:14.000000Z","created_at":"2024-07-10T17:27:14.000000Z","updated_at":"2024-07-10T17:27:14.000000Z"}},{"id":11,"pationt_count":113,"advicor":{"id":11,"name":"د.السيد حراز","email":"sayed.haraz@gmail.com","phone_number":"0123","rule":0,"email_verified_at":"2024-07-10T13:19:59.000000Z","created_at":"2024-07-10T17:19:59.000000Z","updated_at":"2024-07-10T17:19:59.000000Z"}},{"id":12,"pationt_count":65,"advicor":{"id":12,"name":"د .نجوى محجوب","email":"nagwa.mahgob@gmail.com","phone_number":"01234","rule":0,"email_verified_at":"2024-07-19T07:39:13.000000Z","created_at":"2024-07-10T17:23:18.000000Z","updated_at":"2024-07-10T17:23:18.000000Z"}},{"id":17,"pationt_count":61,"advicor":{"id":17,"name":"أ.سهى تقي الدين","email":"Soha.takyeldeen@gmail.com","phone_number":"0123456789","rule":0,"email_verified_at":"2024-07-10T13:27:49.000000Z","created_at":"2024-07-10T17:27:49.000000Z","updated_at":"2024-07-10T17:27:49.000000Z"}},{"id":13,"pationt_count":47,"advicor":{"id":13,"name":"د.خليل مصلح","email":"khalil.mosleh@gmail.com","phone_number":"012345","rule":0,"email_verified_at":"2024-07-10T13:25:36.000000Z","created_at":"2024-07-10T17:25:36.000000Z","updated_at":"2024-07-10T17:25:36.000000Z"}},{"id":15,"pationt_count":1,"advicor":{"id":15,"name":"أ.مصطفى جمعه","email":"mostafa.goma@gmail.com","phone_number":"01234567","rule":0,"email_verified_at":"2024-07-10T13:26:31.000000Z","created_at":"2024-07-10T17:26:31.000000Z","updated_at":"2024-07-10T17:26:31.000000Z"}},{"id":19,"pationt_count":0,"advicor":{"id":19,"name":"advicor","email":"advicor@gmail.com","phone_number":"01018698824","rule":0,"email_verified_at":"2024-07-31T18:11:05.000000Z","created_at":"2024-07-31T22:11:05.000000Z","updated_at":"2024-07-31T22:11:05.000000Z"}},{"id":14,"pationt_count":0,"advicor":{"id":14,"name":"أ.هاني","email":"hany@gmail.com","phone_number":"0123456","rule":0,"email_verified_at":"2024-07-10T13:26:03.000000Z","created_at":"2024-07-10T17:26:03.000000Z","updated_at":"2024-07-10T17:26:03.000000Z"}}],"need_other_session":444,"no_need_other_session":444}

class HomeAdminModel {
  bool? status;
  int? errNum;
  String? message;
  HomeAdmin? home;
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
  int? pationtsCount;
  int? sessionsCount;
  int? successStoryCount;
  List<TopAdvicors>? topAdvicors;
  List<AdvisorsStatistics>? advisorsStatistics;
  int? needOtherSession;
  int? noNeedOtherSession;
  int? numberOfOutnes ;

  HomeAdmin({
      this.pationtsCount, 
      this.sessionsCount, 
      this.successStoryCount, 
      this.topAdvicors, 
      this.needOtherSession, 
      this.noNeedOtherSession,
      this.numberOfOutnes,
      this.advisorsStatistics,
  });

  HomeAdmin.fromJson(dynamic json) {
    pationtsCount = json['pationts_count'];
    sessionsCount = json['sessions_count'];
    successStoryCount = json['success_story_count'];
    numberOfOutnes = json['numberOfOutnes'];
    if (json['top_advicors'] != null) {
      topAdvicors = [];
      json['top_advicors'].forEach((v) {
        topAdvicors?.add(TopAdvicors.fromJson(v));
      });
    }
    if (json['advisorsStatistics'] != null) {
      advisorsStatistics = [];
      json['advisorsStatistics'].forEach((v) {
        print('====================) ${v}');
        advisorsStatistics?.add(AdvisorsStatistics.fromJson(v));
      });
    }
    needOtherSession = json['need_other_session'];
    noNeedOtherSession = json['no_need_other_session'];
  }

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

class AdvisorsStatistics {
  String? name;
  int? asMainAdvisor;
  int? asPastAdvisor;

  AdvisorsStatistics({
      this.name,
      this.asMainAdvisor,
      this.asPastAdvisor,});

  AdvisorsStatistics.fromJson(dynamic json) {
    name = json['name'];
    asMainAdvisor = json['asMainAdvisor'];
    asPastAdvisor = json['asPastAdvisor'] ;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['asMainAdvisor'] = asMainAdvisor;
    map['asPastAdvisor'] = asPastAdvisor;
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
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  int? rule;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;

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


// {
//   status: true,
//   errNum: 0,
//   message: success,
//   home: {
//     pationts_count: 1258,
//     sessions_count: 1692,
//     success_story_count: 39,
//     need_other_session: 626,
//     no_need_other_session: 630,
//     top_advicors: [
//       {id: 16,pationt_count: 446,advicor: {id: 16,name: أ.ايه حجازى,email: aya.hegazy@gmail.com,phone_number: 012345678,rule: 0,email_verified_at: 2024-09-17T18:50:23.000000Z, created_at: 2024-07-10T17:27:14.000000Z, updated_at: 2024-07-10T17:27:14.000000Z}},
//       {id: 18, pationt_count: 439, advicor: {id: 18, name: أ.رحاب سكيك, email: rehab.sekaik@gmail.com, phone_number: 123456, rule: 0, email_verified_at: 2025-04-28T16:11:32.000000Z, created_at: 2024-07-10T17:28:31.000000Z, updated_at: 2025-04-28T20:11:32.000000Z}},
//       {id: 11, pationt_count: 128, advicor: {id: 11, name: د.السيد حراز, email: sayed.haraz@gmail.com, phone_number: 0123, rule: 0, email_verified_at: 2024-09-17T18:50:55.000000Z, created_at: 2024-07-10T17:19:59.000000Z, updated_at: 2024-07-10T17:19:59.000000Z}},
//       {id: 15, pationt_count: 44, advicor: {id: 15, name: أ.مصطفى جمعه, email: mostafa.goma@gmail.com, phone_number: 01234567, rule: 0, email_verified_at: 2024-09-17T18:50:29.000000Z, created_at: 2024-07-10T17:26:31.000000Z, updated_at: 2024-07-10T17:26:31.000000Z}},
//       {id: 14, pationt_count: 32, advicor: {id: 14, name: أ.هانى, email: hany@gmail.com, phone_number: 0123456, rule: 0, email_verified_at: 2024-09-17T18:50:35.000000Z, created_at: 2024-07-10T17:26:03.000000Z, updated_at: 2024-07-10T17:26:03.000000Z}},
//       {id: 17, pationt_count: 25, advicor: {id: 17, name: أ.سهى تقى الدين, email: Soha.takyeldeen@gmail.com, phone_number: 0123456789, rule: 0, email_verified_at: 2024-09-17T18:50:17.000000Z, created_at: 2024-07-10T17:27:49.000000Z, updated_at: 2024-07-10T17:27:49.000000Z}},
//       {id: 12, pationt_count: 25, advicor: {id: 12, name: د .نجوى محجوب, email: nagwa.mahgob@gmail.com, phone_number: 01234, rule: 0, email_verified_at: 2024-07-19T07:39:13.000000Z, created_at: 2024-07-10T17:23:18.000000Z, updated_at: 2024-07-10T17:23:18.000000Z}},
//       {id: 21, pationt_count: 18, advicor: {id: 21, name: الدكتور رائد عبدالهادي, email: ceo@aei.ae, phone_number: 0504167144, rule: 0, email_verified_at: 2025-01-07T10:49:10.000000Z, created_at: 2025-01-07T15:49:10.000000Z, updated_at: 2025-01-07T15:49:10.000000Z}},
//       {id: 13, pationt_count: 9, advicor: {id: 13, name: د.خليل مصلح, email: khalil.mosleh@gmail.com, phone_number: 012345, rule: 0, email_verified_at: 2024-09-17T18:50:41.000000Z, created_at: 2024-07-10T17:25:36.000000Z, updated_at: 2024-07-10T17:25:36.000000Z}}
//     ],
//     advisorsStatistics: [
//       {
//         name: admin,
//         asPastAdvisor: 0,
//         asMainAdvisor: 27
//       },
//       {
//         name: د.السيد حراز,
//         asPastAdvisor: 28,
//         asMainAdvisor: 152
//       },
//       {
//         name: د .نجوى محجوب,
//         asPastAdvisor: 44,
//         asMainAdvisor: 66
//       },
//       {
//         name: د.خليل مصلح,
//         asPastAdvisor: 40,
//         asMainAdvisor: 49
//       },
//       {
//         name: أ.هانى,
//         asPastAdvisor: 6,
//         asMainAdvisor: 0
//       },
//       {
//         name: أ.مصطفى جمعه,
//         asPastAdvisor: 15,
//         asMainAdvisor: 2
//       },
//       {
//         name: أ.ايه حجازى,
//         asPastAdvisor: 108,
//         asMainAdvisor: 373
//       },
//       {
//         name: أ.سهى تقى الدين,
//         asPastAdvisor: 45,
//         asMainAdvisor: 61
//       },
//       {
//         name: أ.رحاب سكيك,
//         asPastAdvisor: 174,
//         asMainAdvisor: 494
//       },
//       {
//         name: Abu Dhabi,
//         asPastAdvisor: 0,
//         asMainAdvisor: 0
//       },
//       {
//         name: الدكتور رائد عبدالهادي,
//         asPastAdvisor: 8,
//         asMainAdvisor: 0
//       }
//     ],
//     numberOfOutnes: 0
//   }
// }