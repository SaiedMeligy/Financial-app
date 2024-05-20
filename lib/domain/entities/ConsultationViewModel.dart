
class ConsultationModel {
  bool? status;
  int? errNum;
  String? message;
  List<ConsultationServices>? consultationServices;
  ConsultationModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.consultationServices,});

  ConsultationModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['consultationServices'] != null) {
      consultationServices = [];
      json['consultationServices'].forEach((v) {
        consultationServices?.add(ConsultationServices.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (consultationServices != null) {
      map['consultationServices'] = consultationServices?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class ConsultationServices {
  int? id;
  String? name;
  String? description;
  String? createdAt;
  String? updatedAt;
  ConsultationServices({
      this.id, 
      this.name, 
      this.description, 
      this.createdAt, 
      this.updatedAt,});

  ConsultationServices.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}