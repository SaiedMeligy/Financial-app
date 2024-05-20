class AdviceModel {
  AdviceModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.advices,});

  AdviceModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['advices'] != null) {
      advices = [];
      json['advices'].forEach((v) {
        advices?.add(Advices.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Advices>? advices;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (advices != null) {
      map['advices'] = advices?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// text : "نصيحة 11"
/// created_at : "2024-05-19T15:44:00.000000Z"
/// updated_at : "2024-05-19T15:49:22.000000Z"

class Advices {
  Advices({
      this.id, 
      this.text, 
      this.createdAt, 
      this.updatedAt,});

  Advices.fromJson(dynamic json) {
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