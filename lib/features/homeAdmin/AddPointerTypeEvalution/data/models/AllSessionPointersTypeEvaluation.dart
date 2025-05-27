import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/DescImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';

class AllSessionPointersTypeEvaluation {
  List<SessionPointersEvaluations>? sessionPointersEvaluations;
  int? sessionNumber;
  double? totalEvalution;
  int? pointerNumber;
  double? totalPublicEvalution;
  String? patientName;
  List<DescImprovement>? descImprovement;
  List<PointerImprovement>? pointerImprovement;

  AllSessionPointersTypeEvaluation({
    this.sessionPointersEvaluations,
    this.sessionNumber,
    this.totalEvalution,
    this.pointerNumber,
    this.totalPublicEvalution,
    this.descImprovement,
    this.patientName,
    this.pointerImprovement,
  });

  AllSessionPointersTypeEvaluation.fromJson(Map<String, dynamic> json) {
    if (json['sessionPointersEvaluations'] != null) {
      sessionPointersEvaluations = <SessionPointersEvaluations>[];
      json['sessionPointersEvaluations'].forEach((v) {
        sessionPointersEvaluations!.add(SessionPointersEvaluations.fromJson(v));
      });
    }

    sessionNumber = json['sessionNumber'];
    patientName = json['patientName'];
    totalEvalution = json['totalEvalution '];
    pointerNumber = json['pointerNumber'];
    totalPublicEvalution = json['totalPublicEvalution'];

    if (json['DescImprovement'] != null) {
      descImprovement = <DescImprovement>[];
      json['DescImprovement'].forEach((v) {
        descImprovement!.add(DescImprovement.fromJson(v));
      });
    }

    if (json['PointerImprovement'] != null) {
      pointerImprovement = <PointerImprovement>[];
      json['PointerImprovement'].forEach((v) {
        pointerImprovement!.add(PointerImprovement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    if (sessionPointersEvaluations != null) {
      data['sessionPointersEvaluations'] =
          sessionPointersEvaluations!.map((v) => v.toJson()).toList();
    }

    data['sessionNumber'] = sessionNumber;
    data['totalEvalution '] = totalEvalution;
    data['pointerNumber'] = pointerNumber;
    data['totalPublicEvalution'] = totalPublicEvalution;

    // if (descImprovement != null) {
    //   data['DescImprovement'] =
    //       descImprovement!.map((v) => v.toJson()).toList();
    // }

    // if (pointerImprovement != null) {
    //   data['PointerImprovement'] =
    //       pointerImprovement!.map((v) => v.toJson()).toList();
    // }

    return data;
  }
}
