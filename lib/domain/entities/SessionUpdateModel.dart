class SessionsUpdateModel{
  int? sessionId;
  String? comments;
  int? consultationId;
  int? isAttend;
  int? needOtherSession;
  int? isSuccessStory;
  int? isFinished;

  SessionsUpdateModel({this.sessionId, this.comments, this.needOtherSession, this.isAttend, this.isFinished,this.consultationId,this.isSuccessStory});


}