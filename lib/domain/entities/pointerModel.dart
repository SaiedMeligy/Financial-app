class PointerModel {
  PointerModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.pointers,});

  PointerModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['pointers'] != null) {
      pointers = [];
      json['pointers'].forEach((v) {
        pointers?.add(Pointers.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Pointers>? pointers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (pointers != null) {
      map['pointers'] = pointers?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}



class Pointers {
  Pointers({
      this.id, 
      this.text, 
      this.senarioId, 
      this.createdAt, 
      this.updatedAt,});

  Pointers.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    senarioId = json['senario_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? text;
  int? senarioId;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['text'] = text;
    map['senario_id'] = senarioId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}