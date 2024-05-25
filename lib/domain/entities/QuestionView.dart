/// status : true
/// errNum : 0
/// message : "success"
/// questions : [{"id":59,"title":"الا","axis_id":1,"created_at":"2024-05-21T23:12:59.000000Z","updated_at":"2024-05-21T23:12:59.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":45,"question_id":59,"type":1,"required":1,"title":"لابب","created_at":"2024-05-21T23:12:59.000000Z","updated_at":"2024-05-21T23:12:59.000000Z"},{"id":46,"question_id":59,"type":1,"required":1,"title":"لايلا","created_at":"2024-05-21T23:12:59.000000Z","updated_at":"2024-05-21T23:12:59.000000Z"}]},{"id":62,"title":"اين تسكن؟","axis_id":1,"created_at":"2024-05-21T23:19:56.000000Z","updated_at":"2024-05-21T23:19:56.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":47,"question_id":62,"type":1,"required":1,"title":"القاهرة","created_at":"2024-05-21T23:19:56.000000Z","updated_at":"2024-05-21T23:19:56.000000Z"},{"id":48,"question_id":62,"type":2,"required":0,"title":"الجيزة","created_at":"2024-05-21T23:19:56.000000Z","updated_at":"2024-05-21T23:19:56.000000Z"}]},{"id":63,"title":"لونك المفضل","axis_id":1,"created_at":"2024-05-21T23:22:15.000000Z","updated_at":"2024-05-21T23:22:15.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":49,"question_id":63,"type":1,"required":1,"title":"احمر","created_at":"2024-05-21T23:22:15.000000Z","updated_at":"2024-05-21T23:22:15.000000Z"},{"id":50,"question_id":63,"type":2,"required":1,"title":"ازرق","created_at":"2024-05-21T23:22:15.000000Z","updated_at":"2024-05-21T23:22:15.000000Z"},{"id":51,"question_id":63,"type":3,"required":0,"title":"اصفر","created_at":"2024-05-21T23:22:15.000000Z","updated_at":"2024-05-21T23:22:15.000000Z"}]},{"id":64,"title":"vdvdv","axis_id":1,"created_at":"2024-05-22T00:06:40.000000Z","updated_at":"2024-05-22T00:06:40.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":52,"question_id":64,"type":2,"required":1,"title":"dvd","created_at":"2024-05-22T00:06:40.000000Z","updated_at":"2024-05-22T00:06:40.000000Z"},{"id":53,"question_id":64,"type":1,"required":1,"title":"vdbd","created_at":"2024-05-22T00:06:40.000000Z","updated_at":"2024-05-22T00:06:40.000000Z"}]},{"id":65,"title":"هل المستفيد عليه ديون","axis_id":1,"created_at":"2024-05-23T22:05:46.000000Z","updated_at":"2024-05-23T22:05:46.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":54,"question_id":65,"type":1,"required":1,"title":"نعم","created_at":"2024-05-23T22:05:46.000000Z","updated_at":"2024-05-23T22:05:46.000000Z"},{"id":55,"question_id":65,"type":1,"required":0,"title":"لا","created_at":"2024-05-23T22:05:47.000000Z","updated_at":"2024-05-23T22:05:47.000000Z"}]}]

class QuestionView {
  QuestionView({
      this.status, 
      this.errNum, 
      this.message, 
      this.questions,});

  QuestionView.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Questions>? questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 59
/// title : "الا"
/// axis_id : 1
/// created_at : "2024-05-21T23:12:59.000000Z"
/// updated_at : "2024-05-21T23:12:59.000000Z"
/// axis : {"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"}
/// question_options : [{"id":45,"question_id":59,"type":1,"required":1,"title":"لابب","created_at":"2024-05-21T23:12:59.000000Z","updated_at":"2024-05-21T23:12:59.000000Z"},{"id":46,"question_id":59,"type":1,"required":1,"title":"لايلا","created_at":"2024-05-21T23:12:59.000000Z","updated_at":"2024-05-21T23:12:59.000000Z"}]

class Questions {
  Questions({
      this.id, 
      this.title, 
      this.axisId, 
      this.createdAt, 
      this.updatedAt, 
      this.axis, 
      this.questionOptions,});

  Questions.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    axisId = json['axis_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    axis = json['axis'] != null ? Axis.fromJson(json['axis']) : null;
    if (json['question_options'] != null) {
      questionOptions = [];
      json['question_options'].forEach((v) {
        questionOptions?.add(QuestionOptions.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  int? axisId;
  String? createdAt;
  String? updatedAt;
  Axis? axis;
  List<QuestionOptions>? questionOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['axis_id'] = axisId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (axis != null) {
      map['axis'] = axis?.toJson();
    }
    if (questionOptions != null) {
      map['question_options'] = questionOptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 45
/// question_id : 59
/// type : 1
/// required : 1
/// title : "لابب"
/// created_at : "2024-05-21T23:12:59.000000Z"
/// updated_at : "2024-05-21T23:12:59.000000Z"

class QuestionOptions {
  QuestionOptions({
      this.id, 
      this.questionId, 
      this.type, 
      this.required, 
      this.title, 
      this.createdAt, 
      this.updatedAt,});

  QuestionOptions.fromJson(dynamic json) {
    id = json['id'];
    questionId = json['question_id'];
    type = json['type'];
    required = json['required'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? questionId;
  int? type;
  int? required;
  String? title;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question_id'] = questionId;
    map['type'] = type;
    map['required'] = required;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// id : 1
/// name : "المحور الاول"
/// created_at : "2024-05-15T01:00:33.000000Z"
/// updated_at : "2024-05-15T01:01:45.000000Z"

class Axis {
  Axis({
      this.id, 
      this.name, 
      this.createdAt, 
      this.updatedAt,});

  Axis.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}