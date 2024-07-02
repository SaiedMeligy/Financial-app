import 'package:dio/dio.dart';

sealed class UpdateSessionStates {}

class LoadingUpdateSessionState extends UpdateSessionStates {}

class SuccessUpdateSessionState extends UpdateSessionStates {
  final Response response;

  SuccessUpdateSessionState(this.response);
}

class ErrorUpdateSessionState extends UpdateSessionStates {
  final String errorMessage;

  ErrorUpdateSessionState(this.errorMessage);
}
