import 'AnswersData.dart';

class QuestionsStatistics {
  String? title;
  List<AnswersData>? answersData;

  QuestionsStatistics({this.title, this.answersData});

  QuestionsStatistics.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['answersData'] != null) {
      answersData = <AnswersData>[];
      json['answersData'].forEach((v) {
        answersData!.add(new AnswersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.answersData != null) {
      data['answersData'] = this.answersData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}