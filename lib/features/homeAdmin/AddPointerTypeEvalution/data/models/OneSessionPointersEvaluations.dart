import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';

class OneSessionPointersEvaluations {
  List<SessionPointersEvaluations>? sessionPointersEvaluations;
  double? totalEvaluation;
  int? formID;
  int? sessionId;

  OneSessionPointersEvaluations({this.sessionPointersEvaluations, this.totalEvaluation});

  OneSessionPointersEvaluations.fromJson(Map<String, dynamic> json) {
    if (json['sessionPointersEvaluations'] != null) {
      sessionPointersEvaluations = <SessionPointersEvaluations>[];
      json['sessionPointersEvaluations'].forEach((v) {
        sessionPointersEvaluations!
            .add(new SessionPointersEvaluations.fromJson(v));
      });
    }
    totalEvaluation = json['totalEvaluation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sessionPointersEvaluations != null) {
      data['sessionPointersEvaluations'] =
          this.sessionPointersEvaluations!.map((v) => v.toJson()).toList();
    }
    if(formID != null)
      data['formID'] = this.formID;
    if(sessionId != null)
      data['sessionId'] = this.sessionId;

    return data;
  }
}