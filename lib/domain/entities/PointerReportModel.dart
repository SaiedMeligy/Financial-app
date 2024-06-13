/// status : true
/// errNum : 0
/// message : "success"
/// report : [{"pointer":{"id":7,"senario_id":2,"text":"مؤشر 1 للتجربة","created_at":"2024-05-23T13:51:47.000000Z","updated_at":"2024-05-23T13:51:47.000000Z"},"count":0,"total_pationts":9},{"pointer":{"id":8,"senario_id":1,"text":"مؤشر 2 للتجربة","created_at":"2024-05-23T14:14:13.000000Z","updated_at":"2024-05-23T14:14:13.000000Z"},"count":2,"total_pationts":9},{"pointer":{"id":9,"senario_id":3,"text":"مؤشر السيناريو التالت للتعديل","created_at":"2024-05-23T14:15:39.000000Z","updated_at":"2024-05-23T21:56:36.000000Z"},"count":0,"total_pationts":9},{"pointer":{"id":10,"senario_id":1,"text":"مؤشر 1","created_at":"2024-05-23T22:03:07.000000Z","updated_at":"2024-05-23T22:03:07.000000Z"},"count":3,"total_pationts":9}]

class PointerReportModel {
  PointerReportModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.report,});

  PointerReportModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['report'] != null) {
      report = [];
      json['report'].forEach((v) {
        report?.add(Report.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Report>? report;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (report != null) {
      map['report'] = report?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// pointer : {"id":7,"senario_id":2,"text":"مؤشر 1 للتجربة","created_at":"2024-05-23T13:51:47.000000Z","updated_at":"2024-05-23T13:51:47.000000Z"}
/// count : 0
/// total_pationts : 9

class Report {
  Report({
      this.pointer, 
      this.count, 
      this.totalPationts,});

  Report.fromJson(dynamic json) {
    pointer = json['pointer'] != null ? Pointer.fromJson(json['pointer']) : null;
    count = json['count'];
    totalPationts = json['total_pationts'];
  }
  Pointer? pointer;
  int? count;
  int? totalPationts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (pointer != null) {
      map['pointer'] = pointer?.toJson();
    }
    map['count'] = count;
    map['total_pationts'] = totalPationts;
    return map;
  }

}

/// id : 7
/// senario_id : 2
/// text : "مؤشر 1 للتجربة"
/// created_at : "2024-05-23T13:51:47.000000Z"
/// updated_at : "2024-05-23T13:51:47.000000Z"

class Pointer {
  Pointer({
      this.id, 
      this.senarioId, 
      this.text, 
      this.createdAt, 
      this.updatedAt,});

  Pointer.fromJson(dynamic json) {
    id = json['id'];
    senarioId = json['senario_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? senarioId;
  String? text;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['senario_id'] = senarioId;
    map['text'] = text;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}