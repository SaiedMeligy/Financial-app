/// success : true
/// allSessionPointersEvaluation : [{"sessionPointersEvaluation":[{"pointerName":"ليس لديه أى التزامات أساسية (إيجار منزل)","evaluation":1},{"pointerName":"الوضع المالى للمستفيد متوازن نسبيا","evaluation":2},{"pointerName":"الوضع المالي للمستفيد متوازن مالياً ويغطى الاحتياجات الأساسية","evaluation":8},{"pointerName":"لديه معرفة عامة عن تحديد الأهداف والأولويات","evaluation":9}],"sessionNumber":5,"totalEvalution ":20,"pointerNumber":4,"totalPublicEvalution":5},{"sessionPointersEvaluation":[],"totalEvalution ":0,"pointerNumber":0,"totalPublicEvalution":0}]

class AllEvaluationModel {
  AllEvaluationModel({
    this.success,
    this.allSessionPointersEvaluation,});

  AllEvaluationModel.fromJson(dynamic json) {
    success = json['success'];
    if (json['allSessionPointersEvaluation'] != null) {
      allSessionPointersEvaluation = [];
      json['allSessionPointersEvaluation'].forEach((v) {
        allSessionPointersEvaluation?.add(AllSessionPointersEvaluation.fromJson(v));
      });
    }
  }
  bool? success;
  List<AllSessionPointersEvaluation>? allSessionPointersEvaluation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (allSessionPointersEvaluation != null) {
      map['allSessionPointersEvaluation'] = allSessionPointersEvaluation?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// sessionPointersEvaluation : [{"pointerName":"ليس لديه أى التزامات أساسية (إيجار منزل)","evaluation":1},{"pointerName":"الوضع المالى للمستفيد متوازن نسبيا","evaluation":2},{"pointerName":"الوضع المالي للمستفيد متوازن مالياً ويغطى الاحتياجات الأساسية","evaluation":8},{"pointerName":"لديه معرفة عامة عن تحديد الأهداف والأولويات","evaluation":9}]
/// sessionNumber : 5
/// totalEvalution  : 20
/// pointerNumber : 4
/// totalPublicEvalution : 5

class AllSessionPointersEvaluation {
  AllSessionPointersEvaluation({
    this.sessionPointersEvaluation,
    this.sessionNumber,
    this.totalEvalution,
    this.pointerNumber,
    this.totalPublicEvalution, // Change from int? to double?
  });

  factory AllSessionPointersEvaluation.fromJson(Map<String, dynamic> json) {
    return AllSessionPointersEvaluation(
      sessionPointersEvaluation: json['sessionPointersEvaluation'] != null
          ? (json['sessionPointersEvaluation'] as List)
          .map((v) => SessionPointersEvaluation.fromJson(v))
          .toList()
          : null,
      sessionNumber: json['sessionNumber'],
      totalEvalution: json['totalEvalution '], // Note the space in the key
      pointerNumber: json['pointerNumber'],
      totalPublicEvalution: json['totalPublicEvalution']?.toDouble(), // Convert to double
    );
  }

  List<SessionPointersEvaluation>? sessionPointersEvaluation;
  int? sessionNumber;
  int? totalEvalution;
  int? pointerNumber;
  double? totalPublicEvalution; // Updated to double?

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (sessionPointersEvaluation != null) {
      map['sessionPointersEvaluation'] =
          sessionPointersEvaluation?.map((v) => v.toJson()).toList();
    }
    map['sessionNumber'] = sessionNumber;
    map['totalEvalution '] = totalEvalution;
    map['pointerNumber'] = pointerNumber;
    map['totalPublicEvalution'] = totalPublicEvalution;
    return map;
  }
}
/// pointerName : "ليس لديه أى التزامات أساسية (إيجار منزل)"
/// evaluation : 1

class SessionPointersEvaluation {
  SessionPointersEvaluation({
    this.pointerName,
    this.evaluation,});

  SessionPointersEvaluation.fromJson(dynamic json) {
    pointerName = json['pointerName'];
    evaluation = json['evaluation'];
  }
  String? pointerName;
  int? evaluation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['pointerName'] = pointerName;
    map['evaluation'] = evaluation;
    return map;
  }

}