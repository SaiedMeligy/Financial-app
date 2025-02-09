
import 'package:dio/dio.dart';

sealed class AddSessionStates{}
class LoadingAddSessionState extends AddSessionStates{}
class SuccessPatientNationalIdState extends AddSessionStates{
  final dynamic result;
  SuccessPatientNationalIdState(this.result);
}
class SuccessAddSessionState extends AddSessionStates{
  final Response result;
  SuccessAddSessionState(this.result);

}
class SuccessShowSession extends AddSessionStates{
  final Response result;
  SuccessShowSession(this.result);

}
class SuccessDeleteSession extends AddSessionStates{
  final Response result;
  SuccessDeleteSession(this.result);

}
class SuccessDeleteQuestionFromForm extends AddSessionStates{
  final Response result;
  SuccessDeleteQuestionFromForm(this.result);

}
class SuccessShowSessionWithAdmin extends AddSessionStates{
  final Response result;
  SuccessShowSessionWithAdmin(this.result);

}

class ErrorAddSessionState extends AddSessionStates{
  final String errorMessage;
  ErrorAddSessionState(this.errorMessage);
}
class ErrorFormState extends AddSessionStates{
  ErrorFormState();
}
class NavigateBackState extends AddSessionStates{
  NavigateBackState();
}
