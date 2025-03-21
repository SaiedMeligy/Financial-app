import 'package:experts_app/domain/entities/EvaluationModel.dart';

sealed class States{}
class LoadingSessionState extends States{}
class SuccessNationalIdState extends States{
  final dynamic result;
  SuccessNationalIdState(this.result);
}
class SuccessSessionState extends States{
  final dynamic result;
  SuccessSessionState(this.result);

}
class LoadingEvaluationSessionState extends States{
  LoadingEvaluationSessionState();

}
class SuccessEvaluationSessionState extends States{
   dynamic evaluationModel;
  SuccessEvaluationSessionState(this.evaluationModel);
}

class ErrorSessionState extends States{
  final String errorMessage;
  ErrorSessionState(this.errorMessage);
}
class ErrorFormState extends States{

  ErrorFormState();
}