
class QuestionModel {
  QuestionModel({
      this.status, 
      this.errNum, 
      this.message, 
      this.questions,});

  QuestionModel.fromJson(dynamic json) {
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

}
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
        pointers?.add(Pointers.fromJson(v));
      });
    }
    if (json['advices'] != null) {
      advices = [];
      json['advices'].forEach((v) {
        advices?.add(Questions.fromJson(v));
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
  List<Pointers>? pointers;
  List<dynamic>? advices;
  List<dynamic>? reletedQuestions;

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

/// id : 22
/// senario_id : 2
/// text : "لديه التزامات ضرورية (ايجار منزل) ويستطيع سدادها الى حد ما"
/// created_at : "2024-06-26T15:52:08.000000Z"
/// updated_at : "2024-06-26T16:44:44.000000Z"

class Pointers {
  Pointers({
      this.id, 
      this.senarioId, 
      this.text, 
      this.createdAt, 
      this.updatedAt,});

  Pointers.fromJson(dynamic json) {
    id = json['id'];
    senarioId = json['senario_id'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? senarioId;
  String? text;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['senario_id'] = senarioId;
    map['text'] = text;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
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