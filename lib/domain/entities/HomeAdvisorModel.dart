/// status : true
/// errNum : 0
/// message : "success"
/// home : {"pationts_count":2,"sessions_count":4,"up_comming_session":{"id":9,"session_number":1,"advicor_id":9,"past_advicor_id":9,"pationt_id":19,"case_manager":"سعيد مليجي","phone_number":"0123","other_phone_number":"01156366044","date":"2024-06-22","time":"16:25","comments":"يبدو ان المسيتفيد احمد بحاجه الي جلسة","consultation_service_id":null,"is_attended":null,"need_other_session":null,"is_success_story":0,"is_finished":0,"created_at":"2024-06-22T13:25:53.000000Z","updated_at":"2024-06-22T13:25:53.000000Z","pationt":{"id":19,"name":"ahmed","email":"ahmed@gmail.com","phone_number":"0123","national_id":"0123","advicor_id":9,"created_at":"2024-06-14T12:33:46.000000Z","updated_at":"2024-06-14T12:35:01.000000Z","is_deleted":0}},"sessions":[{"id":6,"session_number":2,"advicor_id":9,"past_advicor_id":9,"pationt_id":18,"case_manager":"احمد علي","phone_number":"12345","other_phone_number":"01156366044","date":"2024-06-16","time":"TimeOfDay(21:40)","comments":"sfmsnfms","consultation_service_id":3,"is_attended":1,"need_other_session":1,"is_success_story":1,"is_finished":1,"created_at":"2024-06-15T18:40:46.000000Z","updated_at":"2024-06-20T03:49:36.000000Z"},{"id":7,"session_number":3,"advicor_id":9,"past_advicor_id":9,"pationt_id":18,"case_manager":"سيد علي","phone_number":"12345","other_phone_number":"0551445","date":"2024-06-28","time":"TimeOfDay(19:48)","comments":"يبده انه بحالة الي جلسه اخري لتحديد ان الدخل يكفي ام لا","consultation_service_id":6,"is_attended":1,"need_other_session":1,"is_success_story":1,"is_finished":1,"created_at":"2024-06-15T18:49:18.000000Z","updated_at":"2024-06-20T02:43:12.000000Z"},{"id":8,"session_number":4,"advicor_id":9,"past_advicor_id":9,"pationt_id":18,"case_manager":"سعيد عماد","phone_number":"12345","other_phone_number":"01156366044","date":"2024-06-20","time":"16:56","comments":"جلسة سامح","consultation_service_id":6,"is_attended":1,"need_other_session":1,"is_success_story":1,"is_finished":1,"created_at":"2024-06-20T13:57:10.000000Z","updated_at":"2024-06-20T13:58:48.000000Z"},{"id":9,"session_number":1,"advicor_id":9,"past_advicor_id":9,"pationt_id":19,"case_manager":"سعيد مليجي","phone_number":"0123","other_phone_number":"01156366044","date":"2024-06-22","time":"16:25","comments":"يبدو ان المسيتفيد احمد بحاجه الي جلسة","consultation_service_id":null,"is_attended":null,"need_other_session":null,"is_success_story":0,"is_finished":0,"created_at":"2024-06-22T13:25:53.000000Z","updated_at":"2024-06-22T13:25:53.000000Z"}]}

class HomeAdvisorModel {
  HomeAdvisorModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.home,});

  HomeAdvisorModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    home = json['home'] != null ? Home.fromJson(json['home']) : null;
  }
  bool? status;
  int? errNum;
  String? message;
  Home? home;

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

/// pationts_count : 2
/// sessions_count : 4
/// up_comming_session : {"id":9,"session_number":1,"advicor_id":9,"past_advicor_id":9,"pationt_id":19,"case_manager":"سعيد مليجي","phone_number":"0123","other_phone_number":"01156366044","date":"2024-06-22","time":"16:25","comments":"يبدو ان المسيتفيد احمد بحاجه الي جلسة","consultation_service_id":null,"is_attended":null,"need_other_session":null,"is_success_story":0,"is_finished":0,"created_at":"2024-06-22T13:25:53.000000Z","updated_at":"2024-06-22T13:25:53.000000Z","pationt":{"id":19,"name":"ahmed","email":"ahmed@gmail.com","phone_number":"0123","national_id":"0123","advicor_id":9,"created_at":"2024-06-14T12:33:46.000000Z","updated_at":"2024-06-14T12:35:01.000000Z","is_deleted":0}}
/// sessions : [{"id":6,"session_number":2,"advicor_id":9,"past_advicor_id":9,"pationt_id":18,"case_manager":"احمد علي","phone_number":"12345","other_phone_number":"01156366044","date":"2024-06-16","time":"TimeOfDay(21:40)","comments":"sfmsnfms","consultation_service_id":3,"is_attended":1,"need_other_session":1,"is_success_story":1,"is_finished":1,"created_at":"2024-06-15T18:40:46.000000Z","updated_at":"2024-06-20T03:49:36.000000Z"},{"id":7,"session_number":3,"advicor_id":9,"past_advicor_id":9,"pationt_id":18,"case_manager":"سيد علي","phone_number":"12345","other_phone_number":"0551445","date":"2024-06-28","time":"TimeOfDay(19:48)","comments":"يبده انه بحالة الي جلسه اخري لتحديد ان الدخل يكفي ام لا","consultation_service_id":6,"is_attended":1,"need_other_session":1,"is_success_story":1,"is_finished":1,"created_at":"2024-06-15T18:49:18.000000Z","updated_at":"2024-06-20T02:43:12.000000Z"},{"id":8,"session_number":4,"advicor_id":9,"past_advicor_id":9,"pationt_id":18,"case_manager":"سعيد عماد","phone_number":"12345","other_phone_number":"01156366044","date":"2024-06-20","time":"16:56","comments":"جلسة سامح","consultation_service_id":6,"is_attended":1,"need_other_session":1,"is_success_story":1,"is_finished":1,"created_at":"2024-06-20T13:57:10.000000Z","updated_at":"2024-06-20T13:58:48.000000Z"},{"id":9,"session_number":1,"advicor_id":9,"past_advicor_id":9,"pationt_id":19,"case_manager":"سعيد مليجي","phone_number":"0123","other_phone_number":"01156366044","date":"2024-06-22","time":"16:25","comments":"يبدو ان المسيتفيد احمد بحاجه الي جلسة","consultation_service_id":null,"is_attended":null,"need_other_session":null,"is_success_story":0,"is_finished":0,"created_at":"2024-06-22T13:25:53.000000Z","updated_at":"2024-06-22T13:25:53.000000Z"}]

class Home {
  Home({
      this.pationtsCount, 
      this.sessionsCount, 
      this.upCommingSession, 
      this.sessions,});

  Home.fromJson(dynamic json) {
    pationtsCount = json['pationts_count'];
    sessionsCount = json['sessions_count'];
    upCommingSession = json['up_comming_session'] != null ? UpCommingSession.fromJson(json['up_comming_session']) : null;
    if (json['sessions'] != null) {
      sessions = [];
      json['sessions'].forEach((v) {
        sessions?.add(Sessions.fromJson(v));
      });
    }
  }
  int? pationtsCount;
  int? sessionsCount;
  UpCommingSession? upCommingSession;
  List<Sessions>? sessions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pationts_count'] = pationtsCount;
    map['sessions_count'] = sessionsCount;
    if (upCommingSession != null) {
      map['up_comming_session'] = upCommingSession?.toJson();
    }
    if (sessions != null) {
      map['sessions'] = sessions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 6
/// session_number : 2
/// advicor_id : 9
/// past_advicor_id : 9
/// pationt_id : 18
/// case_manager : "احمد علي"
/// phone_number : "12345"
/// other_phone_number : "01156366044"
/// date : "2024-06-16"
/// time : "TimeOfDay(21:40)"
/// comments : "sfmsnfms"
/// consultation_service_id : 3
/// is_attended : 1
/// need_other_session : 1
/// is_success_story : 1
/// is_finished : 1
/// created_at : "2024-06-15T18:40:46.000000Z"
/// updated_at : "2024-06-20T03:49:36.000000Z"

class Sessions {
  Sessions({
      this.id, 
      this.sessionNumber, 
      this.advicorId, 
      this.pastAdvicorId, 
      this.pationtId, 
      this.caseManager, 
      this.phoneNumber, 
      this.otherPhoneNumber, 
      this.date, 
      this.time, 
      this.comments, 
      this.consultationServiceId, 
      this.isAttended, 
      this.needOtherSession, 
      this.isSuccessStory, 
      this.isFinished, 
      this.createdAt, 
      this.updatedAt,});

  Sessions.fromJson(dynamic json) {
    id = json['id'];
    sessionNumber = json['session_number'];
    advicorId = json['advicor_id'];
    pastAdvicorId = json['past_advicor_id'];
    pationtId = json['pationt_id'];
    caseManager = json['case_manager'];
    phoneNumber = json['phone_number'];
    otherPhoneNumber = json['other_phone_number'];
    date = json['date'];
    time = json['time'];
    comments = json['comments'];
    consultationServiceId = json['consultation_service_id'];
    isAttended = json['is_attended'];
    needOtherSession = json['need_other_session'];
    isSuccessStory = json['is_success_story'];
    isFinished = json['is_finished'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? sessionNumber;
  int? advicorId;
  int? pastAdvicorId;
  int? pationtId;
  String? caseManager;
  String? phoneNumber;
  String? otherPhoneNumber;
  String? date;
  String? time;
  String? comments;
  int? consultationServiceId;
  int? isAttended;
  int? needOtherSession;
  int? isSuccessStory;
  int? isFinished;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['session_number'] = sessionNumber;
    map['advicor_id'] = advicorId;
    map['past_advicor_id'] = pastAdvicorId;
    map['pationt_id'] = pationtId;
    map['case_manager'] = caseManager;
    map['phone_number'] = phoneNumber;
    map['other_phone_number'] = otherPhoneNumber;
    map['date'] = date;
    map['time'] = time;
    map['comments'] = comments;
    map['consultation_service_id'] = consultationServiceId;
    map['is_attended'] = isAttended;
    map['need_other_session'] = needOtherSession;
    map['is_success_story'] = isSuccessStory;
    map['is_finished'] = isFinished;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 9
/// session_number : 1
/// advicor_id : 9
/// past_advicor_id : 9
/// pationt_id : 19
/// case_manager : "سعيد مليجي"
/// phone_number : "0123"
/// other_phone_number : "01156366044"
/// date : "2024-06-22"
/// time : "16:25"
/// comments : "يبدو ان المسيتفيد احمد بحاجه الي جلسة"
/// consultation_service_id : null
/// is_attended : null
/// need_other_session : null
/// is_success_story : 0
/// is_finished : 0
/// created_at : "2024-06-22T13:25:53.000000Z"
/// updated_at : "2024-06-22T13:25:53.000000Z"
/// pationt : {"id":19,"name":"ahmed","email":"ahmed@gmail.com","phone_number":"0123","national_id":"0123","advicor_id":9,"created_at":"2024-06-14T12:33:46.000000Z","updated_at":"2024-06-14T12:35:01.000000Z","is_deleted":0}

class UpCommingSession {
  UpCommingSession({
      this.id, 
      this.sessionNumber, 
      this.advicorId, 
      this.pastAdvicorId, 
      this.pationtId, 
      this.caseManager, 
      this.phoneNumber, 
      this.otherPhoneNumber, 
      this.date, 
      this.time, 
      this.comments, 
      this.consultationServiceId, 
      this.isAttended, 
      this.needOtherSession, 
      this.isSuccessStory, 
      this.isFinished, 
      this.createdAt, 
      this.updatedAt, 
      this.pationt,});

  UpCommingSession.fromJson(dynamic json) {
    id = json['id'];
    sessionNumber = json['session_number'];
    advicorId = json['advicor_id'];
    pastAdvicorId = json['past_advicor_id'];
    pationtId = json['pationt_id'];
    caseManager = json['case_manager'];
    phoneNumber = json['phone_number'];
    otherPhoneNumber = json['other_phone_number'];
    date = json['date'];
    time = json['time'];
    comments = json['comments'];
    consultationServiceId = json['consultation_service_id'];
    isAttended = json['is_attended'];
    needOtherSession = json['need_other_session'];
    isSuccessStory = json['is_success_story'];
    isFinished = json['is_finished'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pationt = json['pationt'] != null ? Pationt.fromJson(json['pationt']) : null;
  }
  int? id;
  int? sessionNumber;
  int? advicorId;
  int? pastAdvicorId;
  int? pationtId;
  String? caseManager;
  String? phoneNumber;
  String? otherPhoneNumber;
  String? date;
  String? time;
  String? comments;
  dynamic consultationServiceId;
  dynamic isAttended;
  dynamic needOtherSession;
  int? isSuccessStory;
  int? isFinished;
  String? createdAt;
  String? updatedAt;
  Pationt? pationt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['session_number'] = sessionNumber;
    map['advicor_id'] = advicorId;
    map['past_advicor_id'] = pastAdvicorId;
    map['pationt_id'] = pationtId;
    map['case_manager'] = caseManager;
    map['phone_number'] = phoneNumber;
    map['other_phone_number'] = otherPhoneNumber;
    map['date'] = date;
    map['time'] = time;
    map['comments'] = comments;
    map['consultation_service_id'] = consultationServiceId;
    map['is_attended'] = isAttended;
    map['need_other_session'] = needOtherSession;
    map['is_success_story'] = isSuccessStory;
    map['is_finished'] = isFinished;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (pationt != null) {
      map['pationt'] = pationt?.toJson();
    }
    return map;
  }

}

/// id : 19
/// name : "ahmed"
/// email : "ahmed@gmail.com"
/// phone_number : "0123"
/// national_id : "0123"
/// advicor_id : 9
/// created_at : "2024-06-14T12:33:46.000000Z"
/// updated_at : "2024-06-14T12:35:01.000000Z"
/// is_deleted : 0

class Pationt {
  Pationt({
      this.id, 
      this.name, 
      this.email, 
      this.phoneNumber, 
      this.nationalId, 
      this.advicorId, 
      this.createdAt, 
      this.updatedAt, 
      this.isDeleted,});

  Pationt.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    nationalId = json['national_id'];
    advicorId = json['advicor_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isDeleted = json['is_deleted'];
  }
  int? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? nationalId;
  int? advicorId;
  String? createdAt;
  String? updatedAt;
  int? isDeleted;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['national_id'] = nationalId;
    map['advicor_id'] = advicorId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['is_deleted'] = isDeleted;
    return map;
  }

}