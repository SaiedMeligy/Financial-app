/// status : true
/// errNum : 0
/// message : "تم التعديل بنجاح"

class UpdateConsultationModel {
  UpdateConsultationModel({
      this.status, 
      this.errNum, 
      this.message,});

  UpdateConsultationModel.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
  }
  bool? status;
  int? errNum;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    return map;
  }

}