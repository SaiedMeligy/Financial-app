


import '../../../../domain/entities/AllSessionModel.dart';

abstract class AllSessionStates{}
class LoadingAllSession extends AllSessionStates{}
class SuccessAllSession extends AllSessionStates{
   List<Sessions> session;
  SuccessAllSession(this.session);
}
class SuccessAllSessionWithAdmin extends AllSessionStates{
   List<Sessions> session;
  SuccessAllSessionWithAdmin(this.session);
}

class ErrorAllSession extends AllSessionStates{
  final String errorMessage;
  ErrorAllSession(this.errorMessage);

}