class AllSessionPointersTypeEvaluationEntites {
  List<SessionPointersEvaluationsEntites>? sessionPointersEvaluations;
  int? sessionNumber;
  int? totalEvalution;
  int? pointerNumber;
  int? totalPublicEvalution;

  AllSessionPointersTypeEvaluationEntites(
    {
      this.sessionPointersEvaluations,
      this.sessionNumber,
      this.totalEvalution,
      this.pointerNumber,
      this.totalPublicEvalution
    }
  );
}

class SessionPointersEvaluationsEntites {
  int? id;
  int? pointerId;
  int? evaluation;
  int? sessionId;
  int? sessionNumber;
  String? updatedAt;
  String? createdAt;
  String? pointerName;
  String? desc;

  SessionPointersEvaluationsEntites(
    {
      this.id,
      this.pointerId,
      this.evaluation,
      this.sessionId,
      this.sessionNumber,
      this.updatedAt,
      this.createdAt,
      this.desc,
      this.pointerName
    }
  );

}

class OneSessionPointersEvaluationsEntites{
  List<SessionPointersEvaluationsEntites>? sessionPointersEvaluations;
  int? totalEvaluation;
  int? formID;
  int? sessionId;

  OneSessionPointersEvaluationsEntites({this.sessionPointersEvaluations, this.totalEvaluation});
}