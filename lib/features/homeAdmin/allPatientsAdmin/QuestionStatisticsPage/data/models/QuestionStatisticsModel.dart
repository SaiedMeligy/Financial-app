import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionsStatistics.dart';

class QuestionStatisticsModel {
  List<QuestionsStatistics>? questionsStatistics;
  int? patientCount;
  int? questionOptions;

  QuestionStatisticsModel(
      {this.questionsStatistics, this.patientCount, this.questionOptions});

  QuestionStatisticsModel.fromJson(Map<String, dynamic> json) {
    if (json['questionsStatistics'] != null) {
      questionsStatistics = <QuestionsStatistics>[];
      json['questionsStatistics'].forEach((v) {
        questionsStatistics!.add(new QuestionsStatistics.fromJson(v));
      });
    }
    patientCount = json['patientCount'];
    questionOptions = json['QuestionOptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questionsStatistics != null) {
      data['questionsStatistics'] =
          this.questionsStatistics!.map((v) => v.toJson()).toList();
    }
    data['patientCount'] = this.patientCount;
    data['QuestionOptions'] = this.questionOptions;
    return data;
  }
}