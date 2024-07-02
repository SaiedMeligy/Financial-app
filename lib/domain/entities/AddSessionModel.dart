/// status : true
/// errNum : 0
/// message : "success"
/// sessions : [{"id":1,"session_number":1,"advicor_id":2,"past_advicor_id":9,"pationt_id":13,"case_manager":"سعيد","phone_number":"01156366044","other_phone_number":null,"date":"2024-06-10","time":"12:00","comments":null,"created_at":"2024-06-13T02:44:05.000000Z","updated_at":"2024-06-13T02:44:05.000000Z"},{"id":2,"session_number":2,"advicor_id":2,"past_advicor_id":2,"pationt_id":13,"case_manager":"سعيد","phone_number":"01156366044","other_phone_number":null,"date":"2024-06-10","time":"12:00","comments":null,"created_at":"2024-06-13T02:46:14.000000Z","updated_at":"2024-06-13T02:46:14.000000Z"}]

class AddSessionModel {
  AddSessionModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.sessions,});

  AddSessionModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['sessions'] != null) {
      sessions = [];
      json['sessions'].forEach((v) {
        sessions?.add(Sessions.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Sessions>? sessions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (sessions != null) {
      map['sessions'] = sessions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// session_number : 1
/// advicor_id : 2
/// past_advicor_id : 9
/// pationt_id : 13
/// case_manager : "سعيد"
/// phone_number : "01156366044"
/// other_phone_number : null
/// date : "2024-06-10"
/// time : "12:00"
/// comments : null
/// created_at : "2024-06-13T02:44:05.000000Z"
/// updated_at : "2024-06-13T02:44:05.000000Z"

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
  dynamic otherPhoneNumber;
  String? date;
  String? time;
  dynamic comments;
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
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}