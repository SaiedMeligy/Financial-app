/// status : true
/// errNum : 0
/// message : "success"
/// home : {"senarios_report":[{"id":1,"name":"السيناريو الأول","created_at":"2024-05-20T10:52:17.000000Z","updated_at":"2024-05-20T10:52:17.000000Z","pointers_count":13,"pationts_pointers_count":0},{"id":2,"name":"السناريو الثاني","created_at":"2024-05-20T10:52:17.000000Z","updated_at":"2024-05-20T10:52:17.000000Z","pointers_count":22,"pationts_pointers_count":0},{"id":3,"name":"السناريو الثالث","created_at":"2024-05-20T10:52:17.000000Z","updated_at":"2024-05-20T10:52:17.000000Z","pointers_count":15,"pationts_pointers_count":0}]}

class SenarioModels {
  SenarioModels({
      this.status, 
      this.errNum, 
      this.message, 
      this.home,});

  SenarioModels.fromJson(dynamic json) {
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

/// senarios_report : [{"id":1,"name":"السيناريو الأول","created_at":"2024-05-20T10:52:17.000000Z","updated_at":"2024-05-20T10:52:17.000000Z","pointers_count":13,"pationts_pointers_count":0},{"id":2,"name":"السناريو الثاني","created_at":"2024-05-20T10:52:17.000000Z","updated_at":"2024-05-20T10:52:17.000000Z","pointers_count":22,"pationts_pointers_count":0},{"id":3,"name":"السناريو الثالث","created_at":"2024-05-20T10:52:17.000000Z","updated_at":"2024-05-20T10:52:17.000000Z","pointers_count":15,"pationts_pointers_count":0}]

class Home {
  Home({
      this.senariosReport,});

  Home.fromJson(dynamic json) {
    if (json['senarios_report'] != null) {
      senariosReport = [];
      json['senarios_report'].forEach((v) {
        senariosReport?.add(SenariosReport.fromJson(v));
      });
    }
  }
  List<SenariosReport>? senariosReport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (senariosReport != null) {
      map['senarios_report'] = senariosReport?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "السيناريو الأول"
/// created_at : "2024-05-20T10:52:17.000000Z"
/// updated_at : "2024-05-20T10:52:17.000000Z"
/// pointers_count : 13
/// pationts_pointers_count : 0

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