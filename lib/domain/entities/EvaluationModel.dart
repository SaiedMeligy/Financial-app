
class EvaluationModel {
  EvaluationModel({
      this.success, 
      this.sessionPointersEvaluation, 
      this.totalEvaluation,});

  EvaluationModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['sessionPointersEvaluation'] != null) {
      sessionPointersEvaluation = [];
      json['sessionPointersEvaluation'].forEach((v) {
        sessionPointersEvaluation?.add(SessionPointersEvaluation.fromJson(v));
      });
    }
    totalEvaluation = json['totalEvaluation'];
  }
  bool? success;
  List<SessionPointersEvaluation>? sessionPointersEvaluation;
  double? totalEvaluation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (sessionPointersEvaluation != null) {
      map['sessionPointersEvaluation'] = sessionPointersEvaluation?.map((v) => v.toJson()).toList();
    }
    map['totalEvaluation'] = totalEvaluation;
    return map;
  }

}


class SessionPointersEvaluation {
  SessionPointersEvaluation({
      this.id, 
      this.pointerId, 
      this.evaluation, 
      this.sessionId, 
      this.sessionNumber, 
      this.scenarioNumber, 
      this.updatedAt, 
      this.createdAt, 
      this.pointerName,});

  SessionPointersEvaluation.fromJson(dynamic json) {
    id = json['id'];
    pointerId = json['pointerId'];
    evaluation = json['evaluation'];
    sessionId = json['sessionId'];
    sessionNumber = json['sessionNumber'];
    scenarioNumber = json['scenarioNumber'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    pointerName = json['pointerName'];
  }
  int? id;
  int? pointerId;
  int? evaluation;
  int? sessionId;
  int? sessionNumber;
  int? scenarioNumber;
  String? updatedAt;
  String? createdAt;
  String? pointerName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['pointerId'] = pointerId;
    map['evaluation'] = evaluation;
    map['sessionId'] = sessionId;
    map['sessionNumber'] = sessionNumber;
    map['scenarioNumber'] = scenarioNumber;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    map['pointerName'] = pointerName;
    return map;
  }

}