class SessionPointersEvaluations {
  int? id;
  int? pointerId;
  double? evaluation;
  int? sessionId;
  int? sessionNumber;
  String? updatedAt;
  String? createdAt;
  String? pointerName;
  String? desc;

  SessionPointersEvaluations(
      {this.id,
        this.pointerId,
        this.evaluation,
        this.sessionId,
        this.sessionNumber,
        this.updatedAt,
        this.createdAt,
        this.desc,
        this.pointerName});

  SessionPointersEvaluations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pointerId = json['pointerId'];
    evaluation = json['evaluation'];
    sessionId = json['sessionId'];
    sessionNumber = json['sessionNumber'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    pointerName = json['pointerName'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pointerId'] = this.pointerId;
    data['evaluation'] = this.evaluation;
    data['sessionId'] = this.sessionId;
    data['sessionNumber'] = this.sessionNumber;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['pointerName'] = this.pointerName;
    data['desc'] = this.desc;
    return data;
  }
}