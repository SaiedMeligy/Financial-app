import 'QuestionModel.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';


/// status : true
/// errNum : 0
/// message : "success"
/// questions : [{"id":109,"title":"اسم الزوج","axis_id":1,"is_related_question":0,"created_at":"2024-07-01T19:34:02.000000Z","updated_at":"2024-07-01T19:34:02.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":153,"question_id":109,"type":3,"required":0,"title":"محمد","created_at":"2024-07-01T19:34:02.000000Z","updated_at":"2024-07-01T19:34:02.000000Z","pointers":[],"advices":[],"releted_questions":[]},{"id":154,"question_id":109,"type":3,"required":0,"title":"حسن","created_at":"2024-07-01T19:34:02.000000Z","updated_at":"2024-07-01T19:34:02.000000Z","pointers":[{"id":16,"senario_id":1,"text":"لا يوجد ديون شخصيه وأقساط","created_at":"2024-06-26T15:50:20.000000Z","updated_at":"2024-06-26T15:50:20.000000Z"}],"advices":[],"releted_questions":[]}]},{"id":110,"title":"رقم الهوية","axis_id":1,"is_related_question":0,"created_at":"2024-07-01T19:34:38.000000Z","updated_at":"2024-07-01T19:34:38.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":155,"question_id":110,"type":2,"required":0,"title":"رقم الهوية","created_at":"2024-07-01T19:34:38.000000Z","updated_at":"2024-07-01T19:34:38.000000Z","pointers":[],"advices":[],"releted_questions":[]}]},{"id":111,"title":"أين يعيش","axis_id":1,"is_related_question":0,"created_at":"2024-07-01T19:35:16.000000Z","updated_at":"2024-07-01T19:35:16.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":156,"question_id":111,"type":1,"required":0,"title":"القاهرة","created_at":"2024-07-01T19:35:16.000000Z","updated_at":"2024-07-01T19:35:16.000000Z","pointers":[],"advices":[],"releted_questions":[]},{"id":157,"question_id":111,"type":1,"required":0,"title":"الجيزة","created_at":"2024-07-01T19:35:16.000000Z","updated_at":"2024-07-01T19:35:16.000000Z","pointers":[],"advices":[],"releted_questions":[]}]},{"id":114,"title":"هل لديك قضايا","axis_id":1,"is_related_question":0,"created_at":"2024-07-04T21:27:46.000000Z","updated_at":"2024-07-04T21:27:46.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":161,"question_id":114,"type":1,"required":0,"title":"نعم","created_at":"2024-07-04T21:27:46.000000Z","updated_at":"2024-07-04T21:27:46.000000Z","pointers":[],"advices":[],"releted_questions":[{"id":113,"title":"نوع القضية؟","axis_id":1,"is_related_question":1,"created_at":"2024-07-04T21:27:11.000000Z","updated_at":"2024-07-04T21:27:46.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":160,"question_id":113,"type":3,"required":0,"title":"ماهي نوع القضية؟","created_at":"2024-07-04T21:27:11.000000Z","updated_at":"2024-07-04T21:27:11.000000Z","pointers":[],"advices":[],"releted_questions":[]}]}]},{"id":162,"question_id":114,"type":1,"required":0,"title":"لا","created_at":"2024-07-04T21:27:46.000000Z","updated_at":"2024-07-04T21:27:46.000000Z","pointers":[],"advices":[],"releted_questions":[]}]},{"id":112,"title":"سعيد مليجي","axis_id":2,"is_related_question":0,"created_at":"2024-07-01T19:56:39.000000Z","updated_at":"2024-07-01T19:56:39.000000Z","axis":{"id":2,"name":"المحور التاني","created_at":"2024-05-15T01:00:42.000000Z","updated_at":"2024-05-15T01:00:42.000000Z"},"question_options":[{"id":158,"question_id":112,"type":1,"required":0,"title":"سعيد","created_at":"2024-07-01T19:56:39.000000Z","updated_at":"2024-07-01T19:56:39.000000Z","pointers":[],"advices":[],"releted_questions":[{"id":108,"title":"هل انت متزوج؟","axis_id":1,"is_related_question":1,"created_at":"2024-07-01T19:28:57.000000Z","updated_at":"2024-07-01T19:56:39.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":151,"question_id":108,"type":1,"required":0,"title":"نعم","created_at":"2024-07-01T19:28:57.000000Z","updated_at":"2024-07-01T19:28:57.000000Z","pointers":[],"advices":[{"id":7,"text":"حضور ورش العمل والتدريب ضرورى","created_at":"2024-06-26T15:55:59.000000Z","updated_at":"2024-06-26T15:55:59.000000Z"},{"id":8,"text":"يحتاج لوضع خطة مع الاستشاري ومتابعتها لعدد 2 جلسة لمتابعة تنفيذها بعد حضور التدريب","created_at":"2024-06-26T15:56:17.000000Z","updated_at":"2024-06-26T15:56:17.000000Z"}],"releted_questions":[{"id":107,"title":"اين تسكن؟","axis_id":1,"is_related_question":1,"created_at":"2024-07-01T19:28:25.000000Z","updated_at":"2024-07-01T19:28:57.000000Z","axis":{"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"},"question_options":[{"id":149,"question_id":107,"type":1,"required":0,"title":"القاهرة","created_at":"2024-07-01T19:28:25.000000Z","updated_at":"2024-07-01T19:28:25.000000Z","pointers":[],"advices":[{"id":7,"text":"حضور ورش العمل والتدريب ضرورى","created_at":"2024-06-26T15:55:59.000000Z","updated_at":"2024-06-26T15:55:59.000000Z"}],"releted_questions":[]},{"id":150,"question_id":107,"type":1,"required":0,"title":"الجيزة","created_at":"2024-07-01T19:28:25.000000Z","updated_at":"2024-07-01T19:28:25.000000Z","pointers":[{"id":11,"senario_id":1,"text":"ليس لديه أي التزامات أساسية (إيجار منزل)","created_at":"2024-06-26T15:49:29.000000Z","updated_at":"2024-06-26T16:43:17.000000Z"},{"id":13,"senario_id":1,"text":"السلوك الاستهلاكي مقتصد لا يصرف بالرفاهيات","created_at":"2024-06-26T15:49:53.000000Z","updated_at":"2024-06-26T15:49:53.000000Z"}],"advices":[],"releted_questions":[]}]}]},{"id":152,"question_id":108,"type":1,"required":0,"title":"لا","created_at":"2024-07-01T19:28:57.000000Z","updated_at":"2024-07-01T19:28:57.000000Z","pointers":[{"id":11,"senario_id":1,"text":"ليس لديه أي التزامات أساسية (إيجار منزل)","created_at":"2024-06-26T15:49:29.000000Z","updated_at":"2024-06-26T16:43:17.000000Z"},{"id":12,"senario_id":1,"text":"الوضع المالىي للمستفيد غير متعثر مالياً","created_at":"2024-06-26T15:49:42.000000Z","updated_at":"2024-06-26T15:49:42.000000Z"}],"advices":[],"releted_questions":[]}]}]},{"id":159,"question_id":112,"type":1,"required":0,"title":"مليجي","created_at":"2024-07-01T19:56:39.000000Z","updated_at":"2024-07-01T19:56:39.000000Z","pointers":[],"advices":[],"releted_questions":[]}]}]

class QuestionView {
  QuestionView({
      this.status, 
      this.errNum, 
      this.message, 
      this.questions,});

  QuestionView.fromJson(dynamic json) {
    status = json['status'];
    errNum = json['errNum'];
    message = json['message'];
    if (json['questions'] != null) {
      questions = [];
      json['questions'].forEach((v) {
        questions?.add(Questions.fromJson(v));
      });
    }
  }
  bool? status;
  int? errNum;
  String? message;
  List<Questions>? questions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['errNum'] = errNum;
    map['message'] = message;
    if (questions != null) {
      map['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 109
/// title : "اسم الزوج"
/// axis_id : 1
/// is_related_question : 0
/// created_at : "2024-07-01T19:34:02.000000Z"
/// updated_at : "2024-07-01T19:34:02.000000Z"
/// axis : {"id":1,"name":"المحور الاول","created_at":"2024-05-15T01:00:33.000000Z","updated_at":"2024-05-15T01:01:45.000000Z"}
/// question_options : [{"id":153,"question_id":109,"type":3,"required":0,"title":"محمد","created_at":"2024-07-01T19:34:02.000000Z","updated_at":"2024-07-01T19:34:02.000000Z","pointers":[],"advices":[],"releted_questions":[]},{"id":154,"question_id":109,"type":3,"required":0,"title":"حسن","created_at":"2024-07-01T19:34:02.000000Z","updated_at":"2024-07-01T19:34:02.000000Z","pointers":[{"id":16,"senario_id":1,"text":"لا يوجد ديون شخصيه وأقساط","created_at":"2024-06-26T15:50:20.000000Z","updated_at":"2024-06-26T15:50:20.000000Z"}],"advices":[],"releted_questions":[]}]

class Questions {
  Questions({
      this.id, 
      this.title, 
      this.axisId, 
      this.isRelatedQuestion, 
      this.createdAt, 
      this.updatedAt, 
      this.axis, 
      this.questionOptions,});

  Questions.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    axisId = json['axis_id'];
    isRelatedQuestion = json['is_related_question'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    axis = json['axis'] != null ? Axis.fromJson(json['axis']) : null;
    if (json['question_options'] != null) {
      questionOptions = [];
      json['question_options'].forEach((v) {
        questionOptions?.add(QuestionOptions.fromJson(v));
      });
    }
  }
  int? id;
  String? title;
  int? axisId;
  int? isRelatedQuestion;
  String? createdAt;
  String? updatedAt;
  Axis? axis;
  List<QuestionOptions>? questionOptions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['axis_id'] = axisId;
    map['is_related_question'] = isRelatedQuestion;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (axis != null) {
      map['axis'] = axis?.toJson();
    }
    if (questionOptions != null) {
      map['question_options'] = questionOptions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

    // Override == operator to compare based on id
  @override
  bool operator ==(Object other) {
    return other is Questions && other.id == id;
  }

  // Override hashCode to include id
  @override
  int get hashCode => id.hashCode;


}

/// id : 153
/// question_id : 109
/// type : 3
/// required : 0
/// title : "محمد"
/// created_at : "2024-07-01T19:34:02.000000Z"
/// updated_at : "2024-07-01T19:34:02.000000Z"
/// pointers : []
/// advices : []
/// releted_questions : []

class QuestionOptions {
  QuestionOptions({
      this.id, 
      this.questionId, 
      this.type, 
      this.required, 
      this.title, 
      this.createdAt, 
      this.updatedAt, 
      this.pointers, 
      this.advices, 
      this.reletedQuestions,});

  QuestionOptions.fromJson(dynamic json) {
    id = json['id'];
    questionId = json['question_id'];
    type = json['type'];
    required = json['required'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['pointers'] != null) {
      pointers = [];
      json['pointers'].forEach((v) {
        pointers?.add(

            Pointers.fromJson(v));
      });
    }
    if (json['advices'] != null) {
      advices = [];
      json['advices'].forEach((v) {
        advices?.add(Advices.fromJson(v));
      });
    }
    if (json['releted_questions'] != null) {
      reletedQuestions = [];
      json['releted_questions'].forEach((v) {
        reletedQuestions?.add(Questions.fromJson(v));
      });
    }
  }
  int? id;
  int? questionId;
  int? type;
  int? required;
  String? title;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? pointers;
  List<dynamic>? advices;
  List<Questions>? reletedQuestions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['question_id'] = questionId;
    map['type'] = type;
    map['required'] = required;
    map['title'] = title;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (pointers != null) {
      map['pointers'] = pointers?.map((v) => v.toJson()).toList();
    }
    if (advices != null) {
      map['advices'] = advices?.map((v) => v.toJson()).toList();
    }
    if (reletedQuestions != null) {
      map['releted_questions'] = reletedQuestions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "المحور الاول"
/// created_at : "2024-05-15T01:00:33.000000Z"
/// updated_at : "2024-05-15T01:01:45.000000Z"

class Axis {
  Axis({
      this.id, 
      this.name, 
      this.createdAt, 
      this.updatedAt,});

  Axis.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}