import 'package:experts_app/domain/entities/AdviceMode.dart';

import '../../../../domain/entities/AddSessionModel.dart';


abstract class AllSessionStates{}
class LoadingAllSession extends AllSessionStates{}
class SuccessAllSession extends AllSessionStates{
  final dynamic session;
  SuccessAllSession(this.session);
}

class ErrorAllSession extends AllSessionStates{
  final String errorMessage;
  ErrorAllSession(this.errorMessage);

}