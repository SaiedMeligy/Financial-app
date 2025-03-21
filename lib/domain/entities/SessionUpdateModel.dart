import 'dart:core';

import 'package:experts_app/domain/entities/pointerModel.dart';

import 'AdviceMode.dart';

class SessionsUpdateModel{
  int? sessionId;
  int? sessionNumber;
  List<Map<String, String>>?  pointerEvaluation;
  String? comments;
  int? consultationId;
  String? phoneNumber;
  String? otherPhoneNumber;
  String? caseManager;
  int? isAttend;
  int? needOtherSession;
  int? isSuccessStory;
  int? isFinished;
  List<int>? advices;
  List<int>? pointers;

  SessionsUpdateModel({this.sessionId,this.sessionNumber,
    this.pointerEvaluation,
    this.comments, this.needOtherSession, this.isAttend,
    this.isFinished,this.consultationId,this.isSuccessStory,
    this.phoneNumber,this.otherPhoneNumber,this.caseManager,this.advices,this.pointers});


}