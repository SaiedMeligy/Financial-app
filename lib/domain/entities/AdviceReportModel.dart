/// status : true
/// errNum : 0
/// message : "success"
/// report : [{"advice":{"id":1,"text":"نصيحة 1 تم التعديل","created_at":"2024-05-19T15:44:00.000000Z","updated_at":"2024-05-22T19:48:07.000000Z"},"count":0,"total_pationts":4},{"advice":{"id":5,"text":"المستفيد يحتاج ل ارشاد للاستهلاك المالي","created_at":"2024-05-22T18:19:06.000000Z","updated_at":"2024-05-23T22:02:32.000000Z"},"count":0,"total_pationts":4},{"advice":{"id":6,"text":"المستفيد يحتاج ل جلسات اخرى","created_at":"2024-05-23T22:01:55.000000Z","updated_at":"2024-05-23T22:01:55.000000Z"},"count":0,"total_pationts":4}]

class AdviceReportModel {
  AdviceReportModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.advice,});

  AdviceReportModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['report'] != null) {
      advice = [];
      json['report'].forEach((v) {
        advice?.add(ReportAdvice.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<ReportAdvice>? advice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (advice != null) {
      map['advice'] = advice?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// advice : {"id":1,"text":"نصيحة 1 تم التعديل","created_at":"2024-05-19T15:44:00.000000Z","updated_at":"2024-05-22T19:48:07.000000Z"}
/// count : 0
/// total_pationts : 4

class ReportAdvice {
  ReportAdvice({
      this.advice, 
      this.count, 
      this.totalPationts,});

  ReportAdvice.fromJson(dynamic json) {
    advice = json['advice'] != null ? Advice.fromJson(json['advice']) : null;
    count = json['count'];
    totalPationts = json['total_pationts'];
  }
  Advice? advice;
  int? count;
  int? totalPationts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (advice != null) {
      map['advice'] = advice?.toJson();
    }
    map['count'] = count;
    map['total_pationts'] = totalPationts;
    return map;
  }

}

/// id : 1
/// text : "نصيحة 1 تم التعديل"
/// created_at : "2024-05-19T15:44:00.000000Z"
/// updated_at : "2024-05-22T19:48:07.000000Z"

class Advice {
  Advice({
      this.id, 
      this.text, 
      this.createdAt, 
      this.updatedAt,});

  Advice.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? text;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['text'] = text;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}